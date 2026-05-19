# frozen_string_literal: true

class Devices::BannerComponent < ViewComponent::Base
  def initialize(banner:)
    @banner = banner
  end

  def render?
    @banner.present?
  end
end
