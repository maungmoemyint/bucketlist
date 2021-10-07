class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if(user.present?)
      if(user.authenticate(params[:password]))
        session[:user_id] = user.id
        redirect_to account_ideas_path
      else
        flash[:alert] = 'Email or password were invalid. Please try again'
        render 'new'
      end
    else
      flash[:alert] = 'Email or password were invalid. Please try again'
      render 'new'
    end
  end
end
