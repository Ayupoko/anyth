class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
    @user = current_user
  end

  def edit
  end
  
  def quit
  end
  
  def out
    @user = current_user
    @user.update(is_active: false)
      #ログアウトさせる
      reset_session
      # flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
      redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :status, :is_active )
  end
  
end
