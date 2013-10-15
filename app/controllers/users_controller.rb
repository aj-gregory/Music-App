class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(params[:user])
    @user.session_token = User.generate_session_token
    @user.activation_token = User.generate_activation_token
    @user.activated = false

    if @user.save
      UserMailer.registration_email(@user).deliver
      flash[:errors] = ["Registration email sent"]
      redirect_to new_session_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    @user = current_user
    render :show
  end

  def activate
    @user = User.find_by_activation_token(params[:activation_token])

    if @user
      @user.update_attributes(:activated => true)
      log_in_user!
    else
      flash[:errors] = ["Could not activate account"]
      redirect_to new_session_url
    end
  end

end
