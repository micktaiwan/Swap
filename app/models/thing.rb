class Thing < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo, :styles => { :small => "100x100#", :large => "500x500>" }, :processors => [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_photo, :if => :cropping?
  
  validates_presence_of :name
  
  def percent_off
    if estimated_price and buying_price.to_i!=0
    100-((estimated_price.to_f / buying_price) * 100).to_i
    else
      0
    end
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end
  
private
  
  def reprocess_photo
    photo.reprocess!
  end

end


