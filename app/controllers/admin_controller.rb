class AdminController < ApplicationController
  before_filter :lookup_user, only: [ :accept_director, :decline_director ]
  before_filter :authorize

  def panel
    @pending_directors = User.where(state: 1).paginate(page: params[:page], per_page: 10)
  end

  def accept_director
    respond_to do |format|
      if @user.upgrade_to_director
        format.json { render json: { id: @user.id }, status: :ok }
      else
        format.json { render json: { id: @user.id, errors: @user.errors }, status: :unprocessable_entity }
      end
      format.js
    end
  end

  def decline_director

  end

  private

  def authorize
    authorize! :manage, User
  end

  def lookup_user
    @user = User.find(params[:user_id])
  end
end
