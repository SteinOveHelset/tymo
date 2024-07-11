class UsersController < ApplicationController
  layout "empty"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_user_session_path, notice: "User created successfully. Please log in."
    else
      render :new, status: :unprocessable_entity, alert: "User not created"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end