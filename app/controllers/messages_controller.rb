class MessagesController < ApplicationController

  def new
    @id = params[:id]
  end
  
  def create
    @message = Message.new(params[:message])
    @message.user_id = current_user.id
    @message.thing_id = params[:thing_id]
    if @message.save
      flash[:notice] = I18n.t(:created_msg)
      redirect_to("/things/show/#{@message.thing_id}")
    else
      render :action => 'new'
    end
  end

end
