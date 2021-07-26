class AccountController < ApplicationController
  def ideas
    @ideas = Idea.all
  end
end
