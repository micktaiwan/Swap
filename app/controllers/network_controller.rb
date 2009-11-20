class NetworkController < ApplicationController

  before_filter :verify_session

  def index
    @friends = current_user.friends
    @fans    = current_user.fans
  end
  
  def new
  end
  
  def create
    @email  = params[:friend][:email]
    @name   = params[:friend][:name]
    @msg    = params[:friend][:msg]
    # verify if the email is already in
    @exists = true
    @friend = User.find_by_email(@email)
    if not @friend
      @exists = false
      pwd = generate_pwd
      @friend = User.new(:name=>@name, :email=>@email, :password=>pwd, :password_confirmation=>pwd)
      if not @friend.save
        render(:text=>"$('#msg').html('');alert('#{@friend.errors.full_messages*'\n'}')")
        return
      end
      AppMailer.deliver_invitation(current_user, @friend, @msg, pwd)
    end
    # TODO sent an alert if friend already exist
    if not current_user.has_friend?(@friend.id)
      Network.create(:user_id=>current_user.id, :friend_id=>@friend.id)
      AppMailer.deliver_alert("invite","#{current_user.name} invited #{@friend.name} on Swap!")
    else  
      render(:text=>"$('#msg').html('');alert('#{I18n.t(:already_your_friend, :name=>@name, :name_in_db=>@friend.name)}')")
      return
    end  
  end
  
  def add_as_friend
    Network.create(:user_id=>current_user.id, :friend_id=>params[:id]) if not current_user.has_friend?(params[:id])
    redirect_to "/network/index"    
  end

  def remove_friend
    id = params[:id]
    #Network.destroy_all("user_id='#{current_user.id}' and friend_id='#{id}'")
    redirect_to "/network/index"    
  end

  def resend_invite
    pwd = generate_pwd
    @friend = User.find(params[:id])
    @friend.update_attributes(:password=>pwd, :password_confirmation=>pwd) # risky business
    AppMailer.deliver_invitation(current_user, @friend, "", pwd)
    render(:text=>"ok")
  end
 
end

