class WelcomeController < ApplicationController
  before_action :require_user_logged_in!

  def index
  end

  def blank
  end
end
