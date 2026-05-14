# frozen_string_literal: true

class AddSupportAccessToAccounts < ActiveRecord::Migration[8.0]
  def change
    add_column :accounts, :support_access_at, :datetime
  end
end
