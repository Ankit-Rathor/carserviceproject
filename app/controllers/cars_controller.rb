class CarsController < ApplicationController
  def index
    @cars = current_user.cars
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      flash[:notice] = 'car added!'
      redirect_to new_booking_path
    else   
      flash[:error] = 'invalid vehicle number!'
      render :new   
    end   
  end   

  def update
    car = current_user.cars.find_by(id: params[:id])
    if car.update(car_params)
      flash[:notice] = 'car updated!'   
      redirect_to cars_path   
    else   
      flash[:error] = 'Failed to edit car!'   
      render :edit   
    end   
  end   

  def edit
    @car = current_user.cars.find_by(id: params[:id])
  end

  def destroy
    car = Car.find_by(id: params[:id])
    if car.destroy
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

