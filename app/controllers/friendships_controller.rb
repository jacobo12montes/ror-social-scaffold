class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    @friendship.status = 'Request'

    @inverse = Friendship.new
    @inverse.user_id = params[:user_id]
    @inverse.friend_id = current_user.id
    @inverse.status = 'Pending'

    if @friendship.save && @inverse.save
      redirect_to users_path, notice: 'Friend request successfully.'
    else
      redirect_to users_path, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def update
    @friendship = current_user.inverse_friendships.find_by(user_id: params[:user_id])
    @friendship.status = 'Confirmed'

    @inverse = current_user.friendships.find_by(friend_id: params[:user_id])
    @inverse.status = 'Confirmed'

    if @friendship.save && @inverse.save
      redirect_to users_path, notice: 'Friend request Accepted.'
    else
      redirect_to users_path, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def destroy
    @friendship = current_user.inverse_friendships.find_by(user_id: params[:user_id])

    @inverse = current_user.friendships.find_by(friend_id: params[:user_id])

    Friendship.destroy(@friendship.id)

    Friendship.destroy(@inverse.id)

    redirect_to users_path, notice: 'Friend Deleted.'
  end
end
