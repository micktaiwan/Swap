class PropositionsController < ApplicationController

  def create
    thing = Thing.find(params[:id])
    p = Proposition.create(:thing_id=>thing.id, :user_id=>current_user.id, :owner_id=>thing.user_id)
    AppMailer.deliver_proposition(p)
    redirect_to(:controller=>'things', :action=>'show', :id=>thing.id)
  end

  def destroy_by_thing
    p = Proposition.find_by_user_id_and_thing_id(current_user.id, params[:id])
    AppMailer.deliver_cancel_proposition(p)
    p.destroy
    redirect_to(:controller=>'things', :action=>'show', :id=>params[:id])
  end


end

