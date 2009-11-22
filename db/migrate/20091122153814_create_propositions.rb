class CreatePropositions < ActiveRecord::Migration
  def self.up
    create_table :propositions do |t|
      t.integer :user_id
      t.integer :owner_id
      t.integer :thing_id
      t.timestamps
    end
  end

  def self.down
    drop_table :propositions
  end
end

