class AccountController < ApplicationController
  before_action :ensure_authenticated

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to account_path
  end

  def ideas
    user = User.find(session[:user_id])
    @ideas = user.ideas
  end

  def goals
    @goals = current_user.goals
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar)
  end
end
