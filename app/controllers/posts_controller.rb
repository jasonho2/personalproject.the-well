class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_admin!, only: [:new, :create]

  # GET /posts or /posts.json
  def index
    @posts = Post.order(created_at: :desc).limit(10)
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: "Post created successfully."
    else
      redirect_to root_path, alert: "Failed to create post."
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, notice: "Post deleted successfully."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content)
    end

    def require_admin!
      unless current_user&.admin?
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

    def ensure_admin!
      unless current_user.admin?
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
end
