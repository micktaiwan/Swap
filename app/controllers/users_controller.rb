class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def profile
    id = params[:id]
    if not id
      @user = current_user
    else
      @user = User.find(id)
    end
    @things = Thing.find(:all, :conditions=>["user_id=?", @user.id], :order=>"id desc")
    @pros = Proposition.find(:all, :conditions=>["user_id=? or owner_id=?",@user.id, @user.id])
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user]) # do a save
      redirect_back_or_default('/users/profile')
      flash[:notice] = I18n.t(:edited_msg)
    else
      render :action => 'edit'
    end
  end
  
end

