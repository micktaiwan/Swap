class AddLastLogin < ActiveRecord::Migration
  def self.up
    add_column :users, :last_login, :datetime, :default=>nil
  end

  def self.down
    remove_column :users, :last_login
  end
end

