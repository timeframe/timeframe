# frozen_string_literal: true

# :nocov:
class RefreshDisconnectedDeviceScreenshotsJob < ActiveJob::Base
  def perform
    Device.where(model: Device::SCREENSHOTTED_MODELS)
      .where("last_connection_at IS NULL OR last_connection_at < ?", 1.hour.ago)
      .find_each do |device|
        RefreshDeviceScreenshotJob.perform_later(device.id)
      end
  end
end
# :nocov:
