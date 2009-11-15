class CreateThings < ActiveRecord::Migration
  def self.up
    create_table :things do |t|
      t.integer   :user_id, :null=>false
      t.string    :name, :null=>false
      t.string    :description
      t.string    :swap_reason
      t.integer   :cost
      t.integer   :buying_cost
      t.integer   :main_photo_id
      t.timestamps
    end
  end

  def self.down
    drop_table :things
  end
end
