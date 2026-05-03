# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  def test_email_with_plus_is_invalid
    user = User.new(email: "test+alias@example.com")
    assert_not user.valid?
    assert_includes user.errors[:email], "must not contain +"
  end
end
