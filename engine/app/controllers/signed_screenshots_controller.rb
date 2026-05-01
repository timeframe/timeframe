# frozen_string_literal: true

class SignedScreenshotsController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def show
    device = GlobalID::Locator.locate_signed(params[:sgid], for: "screenshot")

    unless device
      return render plain: "Not authorized", status: :unauthorized
    end

    device.refresh_screenshot!(request.base_url) if device.cached_image.blank? || params[:force] == "true"
    device.reload
    log_image_served(device)
    image_data = Base64.strict_decode64(device.cached_image)

    send_data image_data, type: "image/png", disposition: "inline", filename: "#{device.id}.png?#{Time.now.to_i}"
  end

  private

  def log_image_served(device)
    return unless defined?(AuditLog) && device.cached_image_at.present?
    cache_age_seconds = (Time.current - device.cached_image_at).round
    AuditLog.create!(
      subject: device,
      event_type: "image_served",
      metadata: {cache_age_seconds: cache_age_seconds, source: "signed_screenshot"}
    )
  end
end
