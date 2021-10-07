class GoalsController < ApplicationController

  before_action :ensure_authenticated

  def create
    # user = User.find(params[:user_id])
    # user = current_user
    idea = Idea.find(params[:idea_id])

    current_user.goals << idea

    # redirect_to idea_path(idea)

    # To redirect idea path or js dependsing on the format
    # ideas#show is html format response
    # goals#create is js format response

    respond_to do |format|
      format.html { redirect_to idea_path(idea) }
      format.js
      # render create does not need ti include as RoR will figure out
      # format.js { render 'create'}
      #format.js is good enough
    end
  end
end
