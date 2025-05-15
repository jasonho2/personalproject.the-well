class PagesController < ApplicationController
  def home
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def about_us
  end

  def about_me
  end

  def join_us
  end
end
