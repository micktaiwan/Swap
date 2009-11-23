class MessagesController < ApplicationController

  before_filter :verify_session

  def new
    @id = params[:id]
  end
  
  def create
    @message = Message.new(params[:message])
    @message.user_id = current_user.id
    @message.thing_id = params[:thing_id]
    if @message.save
      flash[:notice] = I18n.t(:created_msg)
      thing = Thing.find(params[:thing_id])
      AppMailer.deliver_message(@message, (thing.commentators.collect {|c| c.name_with_email} + [thing.user.name_with_email]).uniq )
      redirect_to("/things/show/#{@message.thing_id}")
    else
      render :action => 'new'
    end
  end

end
