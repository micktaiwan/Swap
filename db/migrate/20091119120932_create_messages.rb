class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.column :thing_id, :integer,  :null=>false
      t.column :user_id,  :integer,  :null=>false
      t.column :message,  :text,     :null=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end

