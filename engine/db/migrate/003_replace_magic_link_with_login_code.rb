class ReplaceMagicLinkWithLoginCode < ActiveRecord::Migration[8.1]
  def change
    if column_exists?(:users, :magic_link_nonce)
      rename_column :users, :magic_link_nonce, :login_code
    end
    add_column :users, :login_code_sent_at, :datetime unless column_exists?(:users, :login_code_sent_at)
    add_column :users, :login_code_attempts, :integer, default: 0, null: false unless column_exists?(:users, :login_code_attempts)
  end
end
