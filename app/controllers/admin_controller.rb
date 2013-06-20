class AdminController < ApplicationController
  before_filter :lookup_user, only: [ :director_action ]
  before_filter :authorize

  def panel
    @pending_directors = User.where(state: 1).paginate(page: params[:page], per_page: 10)
  end

  def director_action
    respond_to do |format|
      user_status = params[:action_perf] == 'accept' ? @user.upgrade_to_director : @user.decline_user_for_director
      if user_status
        format.json { render json: { id: @user.id, action_perf: params[:action_perf] }, status: :ok }
      else
        format.json { render json: { id: @user.id, action_perf: params[:action_perf], errors: @user.errors }, status: :unprocessable_entity }
      end
      format.js
    end
  end

  private

  def authorize
    authorize! :manage, User
  end

  def lookup_user
    @user = User.find(params[:user_id])
  end
end
