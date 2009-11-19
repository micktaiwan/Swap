class CreateNetworks < ActiveRecord::Migration
  def self.up
    create_table :networks, :id=>false do |t|
      t.column :user_id,    :integer, :null=>false
      t.column :friend_id,  :integer, :null=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :networks
  end
end
