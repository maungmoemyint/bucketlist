class GoalsController < ApplicationController

  before_action :ensure_authenticated

  def create
    # user = User.find(params[:user_id])
    # user = current_user
    idea = Idea.find(params[:idea_id])

    current_user.goals << idea

    redirect_to idea_path(idea)
  end
end
