# frozen_string_literal: true

class AddErrorBacktraceToGoodJobExecutions < ActiveRecord::Migration[8.1]
  def change
    add_column :good_job_executions, :error_backtrace, :text, array: true
  end
end
