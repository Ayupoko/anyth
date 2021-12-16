class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:top]
 
  def top
    if current_user.is_active == false
      reset_session
      flash[:error] = "退会済みです。"
      redirect_to new_user_session_path
    end
  end

  def about
  end
end
