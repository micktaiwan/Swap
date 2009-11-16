class WelcomeController < ApplicationController

  def index
    redirect_to "/things/all" #if current_user == nil
  end

end

