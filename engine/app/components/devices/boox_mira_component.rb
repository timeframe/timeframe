# frozen_string_literal: true

class Devices::BooxMiraComponent < ViewComponent::Base
  # :nocov:
  def initialize(view_object:, refresh: false, device: nil, device_url: nil)
    @view_object = view_object
    @refresh = refresh
    @device = device
    @device_url = device_url
  end
  # :nocov:
end
