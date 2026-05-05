# frozen_string_literal: true

class AddCountryCodeToLocations < ActiveRecord::Migration[8.1]
  def change
    add_column :locations, :country_code, :string, limit: 2
  end
end
