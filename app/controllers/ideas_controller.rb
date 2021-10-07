class IdeasController < ApplicationController
  include RolesHelper

  before_action :ensure_authenticated,   only: [:new, :create, :edit, :update]
  before_action :load_idea,              only: [:edit, :update, :destroy]
  before_action :authorize_to_edit_idea, only: [:edit, :update, :destroy]
  # before_action :ensure_owner,         only: [:edit, :update]

  def index
    @search_term = params[:q]
    logger.info("Search completed using #{@search_term}.")
    @ideas = Idea.search(@search_term).page(params[:page])
  end

  def show
    @idea = Idea.find(params[:id])
    @comment = Comment.new
    @display_add_comment = session[:user_id].present?

    if(logged_in?)
      @disable_add_goal = current_user.goals.exists?(@idea.id)
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
    # Remove the following two lines after using @idea in ensure_owner method
    # id = params[:id]
    # @idea = Idea.find(id)
  end

  def update
    # Remove the following line after using @idea in ensure_owner method
    # @idea = Idea.find(params[:id])
    if(@idea.update(idea_resource_params))
      redirect_to account_ideas_path
    else
      render 'edit'
    end
  end

  def destroy
    @idea.destroy!
  end

  private

  def idea_resource_params
    params.require(:idea).permit(:title, :description, :photo_url, :done_count)
  end

  def load_idea
    #make sure before:action to load idea above
    @idea = Idea.find(params[:id])
  end

  # def ensure_owner
  #   redirect_to(account_path) unless(can_edit?(@idea))
  # end

  #Change the method name from ensure_owner to authorize_to_edit_idea

  def authorize_to_edit_idea
    redirect_to(account_path) unless(can_edit?(@idea))
  end
end
