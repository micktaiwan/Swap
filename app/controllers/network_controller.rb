class NetworkController < ApplicationController

  before_filter :verify_session

  def index
  end
  
  def new
  end
  
  def create
    #name = params[:friend][:name]
    #email = params[:friend][:email]
    # verify if the email is already in
    #@friend = User.find_by_email(email)
    render(:text=>'yo')
  end
  

end
