class Admin::UsersController < ApplicationController
  before_action :require_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    unless @user.save
      render :new
      return
    end

    redirect_to admin_user_path, notice: "ユーザー#{@user.name}を登録しました"
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])

    unless @user.update(user_params)
      render :new
      return
    end

    redirect_to admin_user_url(@user), notice: "ユーザー#{@user.name}を更新しました"
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザー#{@user.name}を削除しました"
  end

  private

  def user_params
    params.require(:user).permit(
        :name,
        :email,
        :admin,
        :password,
        :password_confirmation
    )
  end

  def require_admin
    redirect_to root_url unless current_user.admin?
  end
end
