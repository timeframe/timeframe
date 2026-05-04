# frozen_string_literal: true

class AddAppleCalendarSupport < ActiveRecord::Migration[8.1]
  def change
    create_table :apple_accounts do |t|
      t.references :account, null: false, foreign_key: true
      t.text :email, null: false
      t.text :app_specific_password, null: false
      t.string :caldav_principal_url
      t.string :calendar_home_url
      t.timestamps
      t.index [:account_id, :email], unique: true
    end

    add_reference :calendars, :apple_account, foreign_key: true
    add_column :calendars, :caldav_url, :string
  end
end
