# frozen_string_literal: true

class AddErrorBacktraceToGoodJobExecutions < ActiveRecord::Migration[8.1]
  def change
    unless column_exists?(:good_job_executions, :error_backtrace)
      add_column :good_job_executions, :error_backtrace, :text, array: true
    end
  end
end
