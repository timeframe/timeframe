class AddConfigurationToDevices < ActiveRecord::Migration[8.1]
  def change
    add_column :devices, :configuration, :jsonb, default: {}, null: false unless column_exists?(:devices, :configuration)
  end
end
