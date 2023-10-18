class BookingsController < ApplicationController
  before_action :booking_authorization
  skip_before_action :booking_authorization,only: [:confirm,:cancel]

  def booking_authorization
    if current_user.admin?
      redirect_to admins_path
    elsif current_user.mechanic?
      redirect_to mechanic_booking_path
    end
  end

  def index
    @bookings = current_user.bookings
  end

  def new
    @booking = Booking.new
  end
  
  def create
    booking = Booking.new(booking_params)
    if booking.save
      flash[:notice] = 'booking added!'
      redirect_to bookings_path         
    else   
      flash[:error] = 'Failed to edit !'   
      render :new   
    end  
  end 
  
  def update
    booking = current_user.bookings.find(params[:id])
    if booking.update(booking_params)
      flash[:notice] = 'booking updated!'   
      redirect_to bookings_path   
    else   
      flash[:error] = 'Failed to edit car!'   
      render :edit   
    end   
  end   

  def edit
    @booking = current_user.bookings.find(params[:id])
  end

  def destroy
    booking = current_user.bookings.find(params[:id])
    if booking.destroy
      flash[:notice] = 'deleted succesfully'
      redirect_to bookings_path
    else
      flash[:error] = 'Failed to delete !'
      render :destroy
    end
  end

  def confirm
    booking = Booking.find_by(id: params[:id])
    if booking.update(status: 'confirmed')
      BookingConfirmationMailer.booking_confirmation_email(booking).deliver_now
      redirect_to admins_path
    else
      flash[:notice] = "pending"
    end
  end

  def cancel
    booking = Booking.find_by(id: params[:id])
    booking.update(status: 'cancelled')
    redirect_to admins_path 
  end
  
  private
  def booking_params
    params.require(:booking).permit(:issue, :date, :user_id, :service_id, :car_id, :mechanic_id)
  end
end
