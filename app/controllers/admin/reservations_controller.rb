class Admin::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.page(params[:page]).reverse_order
    # binding.pry
  end

  def show
    @reservations = Reservation.where(params[:user_id])
    # @user = params[:user_id].....
    # binding.pry
    # @reservation = Reservation.find(params[:id])
    # @reservations = Reservation.where(user_id: @reservation)
  end
  
  
  

  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :space_id, :start_date, :start_time, :end_date, :end_time)
  end
  
end