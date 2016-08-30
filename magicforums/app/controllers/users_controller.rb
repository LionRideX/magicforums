class UsersController < ApplicationController
  before_action :authenticate!, only: [:edit, :update,:destroy]
  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "YOU'VE HAVE SUCCESSFULLY CREATED AN ACCOUNT"
      redirect_to new_session_path
    else
      flash[:danger] = @user.errors.full_messages
      redirect_to new_user_path
  end
end

  def edit
    @user = User.find_by(id: params[:id])
    authorize @user
  end

  def update
@user = User.find_by(id: params[:id])
authorize @user

if @user.update(user_params)
  flash[:success] = "You have successfully updated your account"
  redirect_to root_path(@user)
else
  flash[:danger] = "Update Failed"
  redirect_to user_path(@user)
  end
end

def destroy
  @user = User.find_by(id: params[:id])
  if  @user.destroy
  flash[:success] = "you have successfully deleted"
  redirect_to user_path(@user)
else
  flash[:danger] = @user.errors.full_messages
  redirect_to edit_user_path(@user)
end
end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :image)
  end
end
