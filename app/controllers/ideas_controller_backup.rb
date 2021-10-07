class IdeasController < ApplicationController
  before_action :ensure_authenticated, only: :edit
  before_action :ensure_owner,         only: :edit

  def index
    @search_term = params[:q]
    logger.info("Search completed using #{@search_term}.")
    @ideas = Idea.search(@search_term)
  end

  def show
    @idea = Idea.find(params[:id])
    @comment = Comment.new
    @display_add_comment = session[:user_id].present?

    if(session[:user_id].present?)
      @user = User.find(session[:user_id])
      @disable_add_goal = @user.goals.exists?(@idea.id)
    else
      @user = nil
    end
  end

  def new
    @idea = Idea.new
  end

  def create
    user = User.find(session[:user_id])
    @idea = Idea.new(idea_resource_params)
    @idea.user = user
    if(@idea.save)
      redirect_to ideas_path
    else
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @idea = Idea.find(id)
  end

  def update
    @idea = Idea.find(params[:id])
    if(@idea.update(idea_resource_params))
      redirect_to account_ideas_path
    else
      render 'edit'
    end
  end

  private

  def idea_resource_params
    params.require(:idea).permit(:title, :description, :photo_url, :done_count)
  end

  def ensure_owner
    idea = Idea.find(params[:id])

    if (idea.user == current_user)
      return
    end

    redirect_to account_path
  end
end
