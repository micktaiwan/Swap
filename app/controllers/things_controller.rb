class ThingsController < ApplicationController

  before_filter :verify_session, :except=>[:index, :all, :show]

  def new
  end
  
  def index
    redirect_to "/things/all"
  end
  
  def create
    @thing = Thing.new(params[:thing])
    @thing.user_id = current_user.id
      
    if @thing.save
      if params[:thing][:photo].blank?
        flash[:notice] = I18n.t(:created_msg)
        redirect_to('/users/profile')
      else
        render :action => "crop"
      end
    else
      render :action => 'new'
    end
  end

  def edit
    verify_owner
    @thing = Thing.find(params[:id])
  end

  def update
    id = params[:id]
    @thing = Thing.find(id)
    if @thing.update_attributes(params[:thing]) # do a save
      if params[:thing][:photo].blank?
        flash[:notice] = I18n.t(:edited_msg)
        redirect_to "/things/show/#{@thing.id}"
      else
        render :action => "crop"
      end
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
    redirect_to "/users/profile"
  end
  
  def show
    id            = params[:id]
    @thing        = Thing.find(id)
    @propositions = Proposition.find(:all, :conditions=>["thing_id=?", id])
  end

private
  
  def verify_owner
    thing = Thing.find_by_id(params[:id])
    redirect_to '/things/permission_error' if not thing or thing.user_id != current_user.id
  end
    
end


