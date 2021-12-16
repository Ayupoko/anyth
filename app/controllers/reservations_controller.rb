class ReservationsController < ApplicationController
     before_action :authenticate_user!
     before_action :reject_reservation
  
  def index
    @reservations = Reservation.where(user_id: current_user.id).page(params[:page]).reverse_order
  end
  
  def new
    @reservation = Reservation.new
    reservation_view_make
  end
  
    
    def confirm
      @reservation = Reservation.new(reservation_params)
    if params[:reservation][:select_space] =="1" 
      @reservation.space_id = "1"
    elsif params[:reservation][:select_space]  == "2"
      @reservation.space_id = "2"
    elsif params[:reservation][:select_space]  == "3"
      @reservation.space_id = "3"
    elsif params[:reservation][:select_space]  == "4"
      @reservation.space_id = "4"
    end
    
    # @reservation.start_time.change(day: @reservation.start_date)
    # @reservation.end_time.change(day: @reservation.end_date)
    
    end
  
  
  def create
    @reservation = Reservation.all
    @reservation = Reservation.new(reservation_params)
    if @reservation.save(context: :check_reserved)
      redirect_to new_reservation_path
    else
      reservation_view_make
      render :new
    end
  end
  
  def show
    redirect_to new_reservation_path
  end
  
  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
    redirect_to reservations_path
  end
  
  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :space_id, :start_date, :start_time, :end_date, :end_time)
  end
  
  def reservation_view_make
    @reservation_dates = []
    wd = ["日", "月", "火", "水", "木", "金", "土"]
    now = Time.now
    one_week_later = now.since(6.days).to_date
    today = now.to_date
    (today..one_week_later).each do |date|
      @reservation_dates << [ date.strftime(("%Y年%-m月%-d日 (#{wd[date.wday]})")), date.strftime(("%Y-%m-%d")) ]
    end
    spaces = Space.all
    @timelines = []
    @space_statuses = []
    # 全スペースの数を数え、それだけ繰り返す
    spaces.size.times do |i|
      @space_statuses << []
    end
    if params[:now].present? && params[:type] == "next"
      @now = params[:now]
      @now = Time.parse(@now) +60*60*11
    elsif params[:now].present? && params[:type] == "back"
      @now = params[:now]
      @now = Time.parse(@now) -60*60*11
    else
      @now = Time.current
    end
    
    range = 1..23
    range.each do |i|
      time = @now - @now.min*60 - @now.sec + 60*30*i
      @timelines << time.strftime("%H:%M")
      spaces.each_with_index do |space, j|
        is_empty = true
        space.reservations.each do |reservation|
          if reservation.start_time <= time && reservation.end_time >= time
            is_empty = false
          end
        end
        if is_empty
          @space_statuses[j] << "⬜️"
        else
          @space_statuses[j] << "⬛️"
        end
      end
    end
  end
  
end


private

  def reject_reservation
    redirect_to homes_reject_path unless current_user.status == true
  end
