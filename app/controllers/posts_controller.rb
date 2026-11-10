class PostsController < ApplicationController
before_action  :authenticate_user!
  def new
    @post = Post.new
  end

  def index
    @post = Post.all
  end

  def show
    @posts = Post.find(params[:id])
  end

  def create
    @post = Post.new(permit_post)
    if @post.save
      flash[:success] = "Success!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path
      flash[:success] = "The post is destroy!"
    else
      redirect_to posts_path
    end
  end

  private

  def permit_post
    params.require(:post).permit(:image, :description)
  end
end
