class Proposition < ActiveRecord::Base

  belongs_to :user
  belongs_to :owner, :foreign_key=>'owner_id', :class_name=>'User'
  belongs_to :thing

end

