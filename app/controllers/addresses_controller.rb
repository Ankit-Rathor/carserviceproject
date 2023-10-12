class AddressesController < ApplicationController
  before_action :address_authorization

  def address_authorization
    if current_user.admin?
      redirect_to admins_path
    elsif current_user.customer?
      redirect_to dash_board_path
    elsif current_user.mechanic?
      redirect_to mechanic_booking_path
    end
  end

  def index
    @addresses = Address.all
  end

  def show
    @address = Address.find_by(id: params[:id])
  end

  def new
    @address = Address.new
    @user = User.find_by(id:params[:id])
  end

  def create
    address = Address.new(address_params)
    if address.save
      flash[:notice] = 'address added!'   
        redirect_to new_car_path(user_id: current_user)
    else   
      flash[:error] = 'Failed to edit address!'   
      render :new  
    end   
  end     
  
  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      flash[:notice] = 'address updated!'
      redirect_to addresses_path(current_user.id)  
    else   
      flash[:error] = 'Failed to edit address!'   
      render :edit
    end 
  end 

  def edit
    @address = Address.find(params[:id])
  end

  def destroy
    address = Address.find(params[:id])
    if address.destroy
      flash[:notice] = 'deleted succesfully'   
      redirect_to addresses_path(current_user.id)  
    else   
      flash[:error] = 'Failed to delete !'   
      render :destroy   
    end   
  end

  private
  def address_params
    params.require(:address).permit(:city, :location, :house_no, :user_id)
  end
end
