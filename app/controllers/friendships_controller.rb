class FriendshipsController < ApplicationController

  def create
    User.find_by(handle: friend_params[:handle])
    friend = User.find_by(handle: friend_params[:handle])
    current_user.friendships.create(friend: friend)
    flash[:notice] = "Friend Added"
    redirect_to dashboard_path
  end

  private

  def friend_params
    params.permit(:handle)
  end

end
