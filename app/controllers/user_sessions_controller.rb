class UserSessionsController < ApplicationController
  layout "empty"
  
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      redirect_to new_user_session_path, alert: "Wrong e-mail or password"
    end
  end
end