class DirectorController < ApplicationController
  before_filter :authorize_director
  respond_to :json, only: [:request_for_director]

  def panel

  end

  def upload_movie

  end

  def request_for_director
    user = User.find(params[:user_id])
    respond_with user.set_pending
  end

  private

  def authorize_director
    authorize! :manage, Moviegem
  end
end
