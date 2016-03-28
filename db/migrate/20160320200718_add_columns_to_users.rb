class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_column :users, :failed_login_count, :integer, :null => false, :default => 0
    add_column :users, :last_login_at, :datetime
  end
end
