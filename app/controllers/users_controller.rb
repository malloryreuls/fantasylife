class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Sign up successful"
      session[:remember_token] = @user.id.to_s
      redirect_to leaderboard_index_path
    else
      flash[:danger] = "Sign up failed, try again"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user = User.update(user_params)
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to :root
  end

private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :picture)
  end

end