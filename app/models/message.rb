class Message < ActiveRecord::Base

  belongs_to :user
  belongs_to :thing
  belongs_to :commentator, :class_name=>'User', :foreign_key=>:user_id
  
end
