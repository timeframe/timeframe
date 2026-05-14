# frozen_string_literal: true

require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "support_access? returns true when support_access_at is set" do
    account = Account.create!(name: "Test")
    account.update!(support_access_at: Time.current)
    assert account.support_access?
  end

  test "support_access? returns false when support_access_at is nil" do
    account = Account.create!(name: "Test")
    refute account.support_access?
  end
end
