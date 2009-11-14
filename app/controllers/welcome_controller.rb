class WelcomeController < ApplicationController

  def index
    redirect_to "/session/new" if current_user == nil
  end

end

