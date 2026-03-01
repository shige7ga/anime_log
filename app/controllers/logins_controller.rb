class LoginsController < ApplicationController

  def new
    @page_title = 'ログイン画面'
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(current_user), notice: 'ログインしました'
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render 'new', status: :unprocessable_entity
    end
  end

end
