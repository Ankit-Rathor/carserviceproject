class MechanicsController < ApplicationController
  before_action :check_authorization, only: [:mechanics_path]

  def check_authorization
    unless current_user.mechanic?
      redirect_to admins_path
    end
  end

  def index
    @mechanics = User.mechanic #show mechanics list
    @booking_mech_id = params[:booking_id]
    if current_user.mechanic?
      redirect_to mechanic_booking_path
    elsif current_user.customer?
      redirect_to dash_board_path
    end
  end

  def show
    mech = User.find_by(id: params[:id])
    @mech_details = Booking.where(mechanic_id: mech.id)
  end

  #update booking mechanic
  def assinework
    mechanic_user = User.find_by(id: params[:mechanic_id])
    booking = Booking.find_by(id: params[:booking_id])
    booking.update(mechanic_id: mechanic_user.id)
    redirect_to mechanics_path(booking_id: booking.id), notice: "Request Send Sucessfully"
  end
  #view show assine booking  to mechanic

  def mechanic_booking
    mechanic_user = User.find_by(id: current_user.id)
    @user_bookings = Booking.where(mechanic_id: mechanic_user.id)
    if current_user.admin?
      redirect_to admins_path
    elsif current_user.customer?
      redirect_to dash_board_path
    end
  end
end

