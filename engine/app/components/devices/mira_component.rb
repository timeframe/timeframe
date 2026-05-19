# frozen_string_literal: true

class Devices::MiraComponent < ViewComponent::Base
  def initialize(view_object:, refresh: false, device: nil, device_url: nil)
    @view_object = view_object
    @refresh = refresh
    @device = device
    @device_url = device_url
  end
end
