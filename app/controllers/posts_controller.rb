class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(permit_post)
    if @post.save
      flash[:success] = "Success!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def edit
  end

  def update
    if @post.update(permit_post)
      flash[:success] = "Post updated!"
      redirect_to post_path(@post), status: :see_other
    else
      flash[:error] = @post.errors.full_messages
      redirect_to edit_post_path(@post), status: :see_other
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "The post is destroy!"
    redirect_to posts_path, status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def require_owner
    unless @post.user == current_user
      flash[:error] = "You can only change your own posts"
      redirect_to posts_path, status: :see_other
    end
  end

  def permit_post
    params.require(:post).permit(:image, :description)
  end
end
