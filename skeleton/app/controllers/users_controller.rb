class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def index 
    redirect_to cats_url
  end

  def create 
    @user = User.new(user_params)

    if @user.save!
      redirect_to user_url(@user)
    else
      render json: @user.errors.full_messages
    end
  end

  def show 
    @user = User.find(params[:id])
    render :show 
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end