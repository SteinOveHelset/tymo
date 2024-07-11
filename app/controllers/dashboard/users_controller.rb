module Dashboard
  class UsersController < ApplicationController
    layout "dashboard"

    # Check if user is authenticated - and set active team
    before_action :check_authenticated
    before_action :set_active_team

    def show
      @user = @active_team.members.find(params[:id])
    end

    def edit
      @user = current_user
    end

    def update
      @user = current_user

      if @user.update(user_params)
        redirect_to dashboard_path, notice: "User successfully updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
      end
  end
end