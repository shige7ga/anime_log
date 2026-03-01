class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @page_title = 'ユーザー一覧'
    @users = User.all.order(id: :asc)
  end

  def new
    @page_title = 'ユーザー登録'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'ユーザーを新規登録しました'
    else
      render :new
    end
  end

  def show
    @page_title = 'ユーザー詳細'
    @posts = @user.posts
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "ユーザー更新に成功しました" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Post.where(user_id: @user.id).destroy_all
    @user.destroy
    session.delete(:user_id)

    respond_to do |format|
      format.html {redirect_to '/', notice: 'ユーザーを削除しました'}
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
