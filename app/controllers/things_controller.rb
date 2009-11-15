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

  def edit
    @thing = Thing.find(params[:id])
  end

  def my
    @things = Thing.find(:all, :conditions=>["user_id=?", current_user.id], :order=>"id desc")
  end
  
  def update
    id = params[:id]
    @thing = Thing.find(id)
    if @thing.update_attributes(params[:thing]) # do a save
      redirect_back_or_default('/things/my')
      flash[:notice] = I18n.t(:edited_msg)
    else
      render :action => 'edit'
    end
  end
end
