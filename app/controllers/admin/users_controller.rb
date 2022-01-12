class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @item = Reservation.select(:id)
    # binding.pry
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.save!
    redirect_to admin_users_path
  end
  
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :status, :is_active )
  end
  
  
end
