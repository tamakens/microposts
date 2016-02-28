class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings]
  before_action :logged_in_user, only: [:show, :edit, :update, :followings]
  before_action :authenticate!, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "修正しました！"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
      #フォローしているユーザー
    @follower = @user.following_users
  end
  
  def followers
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_profile
    params.require(:user).permit(:name, :email, :profile, :area, :birthday, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate!
    if @user != current_user
      redirect_to root_url, flash: { dander: "不正なアクセス" }
    end
  end

end
