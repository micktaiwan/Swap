class Thing < ActiveRecord::Base

  belongs_to :user
  #has_many :photos
  
  validates_presence_of :name
  
  def percent_off
    if estimated_price and buying_price
    100-((estimated_price.to_f / buying_price) * 100).to_i
    else
      0
    end
  end

end

