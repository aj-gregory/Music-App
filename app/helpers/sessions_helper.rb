module SessionsHelper

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in_user!
    if @user.activated
      session[:session_token] = @user.reset_session_token!
      redirect_to bands_url
    else
      flash[:errors] = ["Account not registered"]
      redirect_to new_session_url
    end
  end

end
