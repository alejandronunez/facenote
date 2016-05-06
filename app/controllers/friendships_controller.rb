class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    current_profile = current_user.profile
    @friendships = current_profile.friends
    @all_friends = Friendship.where("profile_id = :cprofile OR (profile1_id = :cprofile AND state = 0)",{:cprofile=> current_profile.id})
    @not_friends = Profile.where.not(:id => @friendships.to_a << current_profile)
    # byebug
    respond_to do |format|
      format.json {
        render :json => {
            :all_friends => @all_friends.to_json(
              :include=>{
                  :profile1=>{
                      :only => [:id,:firstname,:surname],
                      :include=>{
                          :image=>{:methods => :content_url}}},
                  :profile=>{
                      :only => [:id,:firstname,:surname],
                      :include=>{
                          :image=>{:methods => :content_url}}}}),
            :not_friends => @not_friends.to_json(
               :only => [:id,:firstname,:surname],
                  :include=>{
                       :image=>{:methods => :content_url}}),
            :current_profile=> current_profile.id}
      }
      format.html {render index}
    end
  end
  def accept
    f = Friendship.find(params[:id])
    f.state = 1
    f.save
    nf = Friendship.create(:profile => current_user.profile,:profile1 => f.profile,:state=>1)

    respond_to do |format|
      format.json { render :json => nf.to_json(
          :include=>{
              :profile1=>{
                  :only => [:id,:firstname,:surname],
                  :include=>{
                      :image=>{:methods => :content_url}}},
              :profile=>{
                  :only => [:id,:firstname,:surname],
                  :include=>{
                      :image=>{:methods => :content_url}}}}
      )}
      format.html {redirect_to friendships_path}
    end
  end
  def remove_friend
    Friendship.find(params[:id]).destroy
    respond_to do |format|
      format.json { render :json => {}}
      format.html {redirect_to friendships_path}
    end
  end
  def send_request
    f = Friendship.create(:profile => current_user.profile,:profile1_id => params[:id],:state=>0)
    respond_to do |format|
      format.json { render :json => {id:f.id}}
      format.html {redirect_to friendships_path}
    end
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
