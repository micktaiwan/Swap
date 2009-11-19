class NetworkController < ApplicationController

  before_filter :verify_session

  def index
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
    Network.create(:user_id=>current_user.id, :friend_id=>@friend.id)
    AppMailer.deliver_alert("invite","#{current_user.name} invited #{@friend.name} on Swap!")
  end
  
end

