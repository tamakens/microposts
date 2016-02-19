class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :compare_user, only: [:edit, :update]

  def show # 追加
   @user = User.find(params[:id])
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
  
  def compare_user
    if current_user == @user
      # 保存に成功した場合は編集ページへリダイレクト
      # redirect_to 'edit'
    else
     flash[:alert] = "他人のプロフィールは編集できません！"
     redirect_to root_path
    end
  end

  def edit #編集
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      flash[:success] = "プロフィールを編集しました"
      redirect_to root_path
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation,:region)
  end

  def set_user
    @user = User.find(params[:id])
  end


end