class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :require_admin!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :ensure_admin!, only: [ :new, :create ]

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
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, notice: "Post updated."
    else
      render :edit, status: :unprocessable_entity
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
      params.require(:post).permit(:title, :content, :external_url)
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
