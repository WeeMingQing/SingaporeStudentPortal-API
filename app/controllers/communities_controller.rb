class CommunitiesController < ApplicationController
  skip_before_action :authorized, only: %i[index show ComAll]
  before_action :set_community, only: %i[ show update destroy ]

  # GET /communities
  # GET /communities.json
  def index
    @communities = Community.order(id: :asc).uniq(&:header)
    render json: @communities
  end

  def ComAll 
    communities = Community.all 
    render json: communities.order(id: :asc)
  end

  # GET /communities/1
  # GET /communities/1.json
  def show
    community = Community.find(params[:id])
    render json: community.posts.order('created_at': 'desc')
  end

  # POST /communities
  # POST /communities.json
  def create
    comm = Community.where(header: community_params[:header]).find_by(username: session_user.username)
    if comm == nil 
      @community = Community.new(community_params)
      if @community.save
        render :show, status: :created, location: @community
      else
        render json: @community.errors, status: :unprocessable_entity
      end
    else
      comm.user_id = session_user.id
      comm.save
    end
  end

  # PATCH/PUT /communities/1
  # PATCH/PUT /communities/1.json
  def update
    if @community.update(community_params)
      render :show, status: :ok, location: @community
    else
      render json: @community.errors, status: :unprocessable_entity
    end
  end

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    if session_user.id == 1:
      @community.destroy
    else
      comm = session_user.communities
      comm.each do |community|
        if community.header == @community.header
          if community.id == @community.id 
            @community.user_id = 1
            @community.save
          else
            community.destroy
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def community_params
      params.require(:community).permit(:header, :user_id, :username)
    end
end
