class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @page_title = 'ログ登録'
    @post = Post.new
  end

end
