class HomeController < ApplicationController
  before_action :redirect_if_gated

  def index
  end
end
