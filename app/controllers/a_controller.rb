class AController < ApplicationController
  layout 'admin'
  before_filter :verify_admin_login, :except=>:login

  def index
    @users  = User.find(:all, :order=>'id desc')
  end

  def login
  end
  
end

