class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[show index]
  before_action :authorized, only: [:auto_login]
 
   # GET /users or /users.json
   def index
     @users = User.all
     render json: @users
   end
 
  def joinedCommunities  
    @communities = Community.where(user_id: session_user.id).order(id: :asc)
    joined_communities = []
    @communities.each do |community|
      joined_communities.push(Community.order(id: :asc).where(header: community.header).first)
    end
      render json: joined_communities
  end
   # GET /users/1 or /users/1.json
   def show
    user = User.find(params[:id])
    render json: user
   end
 
   # GET /users/new
   def new
     @user = User.new
   end
 
   # GET /users/1/edit
   def edit
   end
 
   # POST /users or /users.json
   def create
     @user = User.create(user_params)
     if @user.valid?
       payload = {user_id: @user.id}
       token = encode_token(payload)
       puts token
       render json: {user: @user, token: token}
     elsif @user.errors.any?
      render json: {error: @user.errors.objects.first.full_message}
     else 
       render json: {error: "Invalid username or password"}, status: :unprocessable_entity
     end
 
   end
 
   # PATCH/PUT /users/1 or /users/1.json
   def update
   end
 
   # DELETE /users/1 or /users/1.json
   def destroy
     @user.destroy
 
     respond_to do |format|
       format.html { redirect_to users_url, notice: "User was successfully destroyed." }
       format.json { head :no_content }
     end
   end
 
   def login
     @user = User.find_by(username: params[:username])
     if @user && @user.authenticate(params[:password])
       payload = {user_id: @user.id}
       token = encode_token(payload)
       render json: {user: @user, token: token, success: "Welcome back, #{@user.username}, #{logged_in?}"}
     else 
       render json: {error: "Log in failed! Username or password invalid!"}
     end
   end
 
   def auto_login
      if session_user
        render json: session_user
      else
        render json: {error: "No User Logged In"}
      end
   end
 
 
   private
     # Use callbacks to share common setup or constraints between actions.
 
     # Only allow a list of trusted parameters through.
     def user_params
       params.require(:user).permit(:username, :email, :password)
     end
 end
 