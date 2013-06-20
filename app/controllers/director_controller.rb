class DirectorController < ApplicationController
  before_filter :authorize_director

  def panel

  end

  def upload_movie

  end

  def request_for_director

  end

  private

  def authorize_director
    authorize! :manage, Moviegem
  end
end
