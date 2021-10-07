class GoalsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    idea = Idea.find(params[:idea_id])

    user.goals << idea

    redirect_to idea_path(idea)
  end
end
