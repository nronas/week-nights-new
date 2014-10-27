class HomeController < ApplicationController
  def index
    if current_user.try(:approved?)
      redirect_to dashboard_path
    end
  end
end
