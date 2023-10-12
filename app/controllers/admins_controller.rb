 class AdminsController < ApplicationController

  def index
    @bookings = Booking.all
    if current_user.mechanic?
      redirect_to mechanic_booking_path
    elsif current_user.customer?
      redirect_to dash_board_path
    end
  end

  def destroy
    @booking = Booking.find_by(id: params[:id])
    if @booking.destroy
      flash[:notice] = 'deleted succesfully'
      redirect_to admins_path 
    else
      flash[:error] = 'Failed to delete !'   
      render :destroy
    end 
  end  
end
