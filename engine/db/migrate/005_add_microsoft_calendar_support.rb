# frozen_string_literal: true

class AddMicrosoftCalendarSupport < ActiveRecord::Migration[8.1]
  def change
    create_table :microsoft_accounts do |t|
      t.references :account, null: false, foreign_key: true
      t.text :microsoft_uid, null: false
      t.text :email, null: false
      t.text :access_token, null: false
      t.text :refresh_token, null: false
      t.datetime :token_expires_at
      t.timestamps
      t.index [:account_id, :microsoft_uid], unique: true
    end

    add_reference :calendars, :microsoft_account, foreign_key: true
  end
end
