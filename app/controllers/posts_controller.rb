class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @page_title = 'ログ一覧'
    @posts = Post.all.order(id: :asc)
  end

  def new
    @page_title = 'ログ登録'
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post[:user_id] = session[:user_id]
    if @post.save
      redirect_to @post, notice: 'ログを新規登録しました'
    else
      render :new
    end
  end

  def show
    @page_title = 'ログ詳細'
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "ログ更新に成功しました" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html {redirect_to posts_url, notice: 'ログを削除しました'}
      format.json { head :no_content }
    end
  end

  private

  def set_post
  @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :comment)
  end
end
