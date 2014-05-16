class SelectionsController < ApplicationController
  before_action :set_selection, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user

  def index
    @selection = Selection.all
  end

  def new
    @user = User.find(params[:user_id])
    if @user == current_user
      @selection = Selection.new
    else
      flash[:danger] = "You can only add selection to your own account!"
      redirect_to users_path(params[:user_id])
    end
  end

  def create
    u = User.find(params[:user_id])
    @selection = u.selections.new(selection_params)
    if @selection.save
      redirect_to user_path(params[:user_id])
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    if @user != current_user
      flash[:danger] = "Edit your own selections"
      redirect_to users_path(params[:user_id])
    end
  end

  def show
  end

  def update
    if @selection.update(selection_params)
      redirect_to user_path(params[:user_id])
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    if @user == current_user
      @selection.destroy
      redirect_to user_path(params[:user_id])
    else
      flash[:danger] = "Delete your own selections"
      redirect_to users_path(params[:user_id])
    end
  end

  private 

  def selection_params
    params.require(:selection).permit(:baseball_team, :football_team, :basketball_team, :hockey_team)
  end

  def set_selection
    @selection = Selection.find(params[:id])
  end

end
