class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def wall
    # asd =current_user
    # byebug
    if(params[:id])
      @profile = Profile.find(params[:id])
    else
      @profile = current_user.profile
    end
    if (@profile)
      @posts = Post.where(:profile =>@profile.friends.to_a << @profile).order(created_at: :desc)
    else
      @posts = [];
    end
    respond_to do |format|
      format.json { render :json => {
            posts:@posts.to_json(
                :only=>[:message,:created_at],
                :include=>{
                    :profile=>{
                        :only => [:id,:firstname,:surname],
                        :include=>{
                            :image=>{:methods => :content_url}}},
                    :comments=>{
                        :only => [:message,:created_at],
                        :include=>{
                            :profile =>{
                                :only => [:id,:firstname,:surname],
                                :include=>{
                                    :image=>{:methods => :content_url}}
                            }
                        }
                    }
                }
            ),
            profile:@profile.to_json(
                :only => [:id,:firstname,:surname],
                :include=>{
                    :image=>{:methods => :content_url}}
            ),
            owner: current_user.profile.id == @profile.id
      }}
      format.html { render :wall }
    end
  end
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    pp = profile_params
    if(profile_params['firstname']&&profile_params['image'])
      image = Image.create({:name=>profile_params['firstname'],:content=>profile_params['image']})
      pp['image'] = image
    end
    # byebug
    respond_to do |format|
      if @profile.update(pp)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    current_user.profile.like!(Post.find(params['post_id']))
    redirect_to :back
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firstname, :surname, :age, :gender, :birday,:image)
    end
end
