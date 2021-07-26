class IdeasController < ApplicationController
  def index
    @search_term = params[:q]
    logger.info("Search completed using #{@search_term}.")
    @ideas = Idea.all
  end

  def new
  end

  def create
    idea = Idea.new
    idea.title = params[:title]
    idea.save!
    redirect_to ideas_index_path
  end
end
