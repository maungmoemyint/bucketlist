class GoalsController < ApplicationController

  before_action :ensure_authenticated

  def create
    @idea = Idea.find(params[:idea_id])

    current_user.goals << @idea

    respond_to do |format|
      format.html { redirect_to idea_path(idea) }
      format.js
    end
  end
end
