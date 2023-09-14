class CarsController < ApplicationController
  def index
    @cars = current_user.cars
  end

  def show
    @car = Car.find_by(id: params[:id])
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    #  @user = @car.user_id 
    if @car.save   
      flash[:notice] = 'car added!'
      redirect_to new_booking_path
    else   
      flash[:error] = 'Failed to edit product!'   
      render :new   
    end   
  end   

  def update
    @car = Car.find(params[:id])   
    if @car.update(car_params)   
      flash[:notice] = 'car updated!'   
      redirect_to cars_path   
    else   
      flash[:error] = 'Failed to edit car!'   
      render :edit   
    end   
  end   

  def edit
    @car = Car.find(params[:id])
  end

  def destroy
    @car = Car.find(params[:id])
    @car.bookings.destroy_all   
    if @car.delete 
      flash[:notice] = 'deleted succesfully'   
      redirect_to cars_path   
    else   
      flash[:error] = 'Failed to delete !'   
      render :destroy   
    end   
  end

  private
  def car_params
    params.require(:car).permit(:name, :number, :model, :company, :user_id)
  end
end

