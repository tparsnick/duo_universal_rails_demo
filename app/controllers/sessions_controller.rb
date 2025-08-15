class SessionsController < ApplicationController
  def new
  end

  def create
    session.clear
    username = params[:username]

    if username.blank?
      flash.now[:error] = "Missing username"
      return render :new
    end

    begin
      DuoClientService.client.health_check
    rescue => e
      Rails.logger.error e.full_message
      if @duo_failmode == "OPEN"
        flash.now[:error] = "2FA health check failed. Failmode is open; 2FA can be bypassed."
        session[:username] = username
        return render "home/index"
      else
        flash.now[:error] = "Login failed. 2FA health check failed. Failmode is closed."
        return render :new
      end
    end

    state = DuoClientService.client.generate_state
    session[:state]    = state
    session[:username] = username

    redirect_to DuoClientService.client.create_auth_url(username: username, state: state), allow_other_host: true
  end

  def duo_callback
    # This handles the redirect(redirect_uri) from Duo after 2FA is completed. code and state are passed parameters.
    state = params[:state]
    code  = params[:duo_code] || params[:code]

    unless session[:state] && session[:username]
      flash.now[:error] = "No saved state, please login again"
      return render :new
    end

    if state != session[:state]
      flash.now[:error] = "Duo state does not match saved state"
      return render :new
    end

    begin
      decoded_token = DuoClientService.client.exchange_authorization_code_for_2fa_result(duo_code: code, username: session[:username])
      @token_info = JSON.pretty_generate(decoded_token)
      session[:duo_authenticated] = true
      render "home/index"
    rescue => e
      flash.now[:error] = "Login failed: #{e.message}"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
