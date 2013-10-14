class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(params[:user])
    @user.session_token = User.generate_session_token

    if @user.save
      session[:session_token] = @user.reset_session_token!
      redirect_to user_url(@user.id)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    @user = current_user
    render :show
  end

end
