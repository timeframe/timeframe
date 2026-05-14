# frozen_string_literal: true

module Auditable
  extend ActiveSupport::Concern

  FILTERED_KEYS = %w[password token code secret key api_key display_key session_token].freeze

  included do
    around_action :audit_action
    attr_writer :audit_subject
  end

  private

  def audit_action
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    result_type = "success"
    error = nil

    begin
      yield
    rescue => e
      result_type = "error"
      error = e
      raise
    ensure
      duration_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time) * 1000).round

      begin
        subject = @audit_subject || infer_audit_subject
        if subject && defined?(CreateAuditLogJob)
          metadata = base_metadata(duration_ms, error).merge(audit_metadata)

          CreateAuditLogJob.perform_later(
            subject_type: subject.class.name,
            subject_id: subject.id,
            user_id: current_user&.id,
            event_type: "#{controller_name}.#{action_name}",
            result_type: result_type,
            metadata: metadata
          )
        end
      rescue => audit_error
        Rails.logger.error("[Auditable] Failed to enqueue audit log: #{audit_error.message}")
      end
    end
  end

  def audit_metadata
    {}
  end

  def infer_audit_subject
    ivar_name = "@#{controller_name.singularize}"
    ivar = instance_variable_get(ivar_name) if instance_variable_defined?(ivar_name)
    ivar if ivar.is_a?(ActiveRecord::Base) && ivar.persisted?
  end

  def base_metadata(duration_ms, error)
    meta = {
      controller: controller_path,
      action: action_name,
      method: request.method,
      duration_ms: duration_ms
    }
    meta[:params] = filter_params(request.filtered_parameters) if request.filtered_parameters.present?
    meta[:error] = {class: error.class.name, message: error.message} if error
    meta
  end

  def filter_params(params)
    filtered = params.except("controller", "action", "format", "utf8", "authenticity_token", "commit")
    filtered.each_with_object({}) do |(key, value), hash|
      hash[key] = (FILTERED_KEYS.any? { |k| key.to_s.downcase.include?(k) }) ? "[FILTERED]" : value
    end
  end
end
