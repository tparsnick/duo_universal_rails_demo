class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper AuthHelper   # makes methods available in views.
  include AuthHelper  # makes methods available in controllers

  before_action :set_duo_failmode

  layout "main"

  private

  def set_duo_failmode
    @duo_failmode = Rails.configuration.duo_config["failmode"].to_s.upcase
  end
end
