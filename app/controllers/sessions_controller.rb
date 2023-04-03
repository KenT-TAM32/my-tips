class SessionsController < ApplicationController

  def new
  end

  def create
    #9章演習問題にてuserを@userに変更（10章以降の本分コードと差異有）
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session           # 必ず記述
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        # remember user
        log_in @user
        redirect_to forwarding_url || @user
      else
        message = "Account not activated. "
        message = "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
