class ThingsController < ApplicationController

  def new
  end
  
  def create
    @thing = Thing.new(params[:thing])
    @thing.user_id = current_user.id
    @thing.save
    if @thing.errors.empty?
      redirect_back_or_default('/things/my')
      flash[:notice] = I18n.t(:created_msg)
    else
      render :action => 'new'
    end
  end

end
