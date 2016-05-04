class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    current_profile = current_user.profile
    @friendships = current_profile.friends
    @all_friends = Friendship.where("profile_id = :cprofile OR (profile1_id = :cprofile AND state = 0)",{:cprofile=> current_profile.id})
    @not_friends = Profile.where.not(:id => @friendships.to_a << current_profile)
    # byebug
  end
  def accept
    f = Friendship.find(params[:id])
    f.state = 1
    f.save
    Friendship.create(:profile => current_user.profile,:profile1 => f.profile,:state=>1)
    redirect_to friendships_path
  end
  def remove_friend
    Friendship.find(params[:id]).destroy
    redirect_to friendships_path
  end
  def send_request
    Friendship.create(:profile => current_user.profile,:profile1_id => params[:id],:state=>0)
    redirect_to friendships_path
  end
  def friends_of
    if (params[:id])
      id = params[:id]
    else
      id = current_user.profile.id
    end
    @all_friends = Friendship.where("profile_id = :cprofile AND state = 1",{:cprofile=> id})
    respond_to do |format|
      format.json {
        render :json => @all_friends.to_json(
          :include=>{
              :profile1=>{
                  :only => [:id,:firstname,:surname],
                  :include=>{
                      :image=>{:methods => :content_url}}}
          }
        )
      }
    end
  end
end
