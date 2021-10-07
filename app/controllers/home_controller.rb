class HomeController < ApplicationController
  def index
    @ideas = Idea.most_recent
  end
end
