module AuthHelper
  def logged_in?
    session[:username].present?
  end

  def duo_authenticated?
    session[:duo_authenticated].present?
  end

  def duo_skip?
    @duo_failmode == "OPEN"
  end

  def redirect_if_gated
    redirect_to login_path unless logged_in? && (duo_skip? || duo_authenticated?)
  end
end

