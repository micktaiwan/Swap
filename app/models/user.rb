require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_many :things
  #has_many :networks
  #has_many :friends, :through=>:networks, :foreign_key=>:friend_id, :class_name=>'User' #, :select => "memberships.active, projects.*"

  def friends # I dont' understand associations well enough....
    User.find_by_sql("select * from users join networks on networks.user_id='#{self.id}' where users.id=networks.friend_id order by id desc")
  end

  def fans # I dont' understand associations well enough....
    User.find_by_sql("select * from users join networks on networks.friend_id='#{self.id}' where users.id=networks.user_id order by id desc")
  end
  
  def friend_of?(user_id)
    Network.find_by_sql("select * from networks where user_id='#{user_id}' and friend_id='#{self.id}'") == [] ? false : true
  end

  def has_friend?(user_id)
    Network.find_by_sql("select * from networks where user_id='#{self.id}' and friend_id='#{user_id}'") == [] ? false : true
  end
  

  #validates_presence_of     :login
  #validates_length_of       :login,    :within => 3..40
  #validates_uniqueness_of   :login
  #validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :name, :password, :password_confirmation, :location, :last_login


  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find_by_email(email.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def short_name
    self.name.split(" ")[0]
  end

  protected

end

