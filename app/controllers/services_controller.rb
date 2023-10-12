class ServicesController < ApplicationController 
  before_action :service_authorization

  def index
    @services = Service.all # show all services
  end
  
  def service_authorization
    if current_user.customer?
      redirect_to dash_board_path
    end
  end

  def new
    @service = Service.new
    if current_user.admin?
      redirect_to admins_path
    end
  end

  #sevice status confirm this method
  def confirm_service
    service = Service.find_by(id: params[:id])
    service.update(status: 'confirm')
    redirect_to service_history_path
  end

  # service status cancel this method
  def cancel_service
    service= Service.find_by(id: params[:id])
    service.update(status: 'cancelled')
    redirect_to service_history_path
  end

  #booking id to service find
  def create
    booking = Booking.find_by(id: params[:service][:booking_id])
    mechanic = booking.mechanic_id # booking in mechanic_id
    service = Service.new(service_params)
    if service.save
      booking.update(service_id: service.id) #update service id in booking
      redirect_to mechanic_booking_path
    else
      render :new
    end
  end

  def service_history
    @bookings_service = Booking.joins(:service)
    if current_user.mechanic?
      redirect_to mechanic_booking_path
    end
  end

  private
  def service_params
    params.require(:service).permit(details: {}) 
  end
end

