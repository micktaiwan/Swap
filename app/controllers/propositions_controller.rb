class PropositionsController < ApplicationController

  def create
    thing = Thing.find(params[:id])
    Proposition.create(:thing_id=>thing.id, :user_id=>current_user.id, :owner_id=>thing.user_id)
    # TODO send an email (every  day ?)
    redirect_to(:controller=>'things', :action=>'show', :id=>thing.id)
  end

  def destroy_by_thing
    Proposition.find_by_user_id_and_thing_id(current_user.id, params[:id]).destroy
    # TODO send an email
    redirect_to(:controller=>'things', :action=>'show', :id=>params[:id])
  end


end

