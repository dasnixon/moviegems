class AdminController < ApplicationController
  def panel
    @pending_directors = User.where(state: 1).paginate(page: params[:page], per_page: 10)
  end
end
