class ThingsController < ApplicationController

  before_filter :verify_session, :except=>[:index, :all]

  def new
    redirect_to "/things/all"
  end
  
  def index
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
    verify_owner
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
  
  def all
    @things = Thing.find(:all, :order=>"id desc")
  end
  
  def permission_error
    render(:text=>"Permission error")
  end

  def destroy
    verify_owner
    id = params[:id].to_i
    if not Thing.destroy(id)
      flash[:error] = I18n.t(:error)
    end
    redirect_to "/things/my"
  end

private
  
  def verify_owner
    thing = Thing.find_by_id(params[:id])
    redirect_to '/things/permission_error' if not thing or thing.user_id != current_user.id
  end
  
  def verify_session
    redirect_to "/session/new" and return if current_user == nil
  end
    
end

