class UsersController < ApplicationController
  # before_action :redirect_if_authenticated, only: [:create]
  skip_before_action :authenticate_user,only: [:new,:create]
  before_action :check_authorization
  skip_before_action :check_authorization, only: [:update,:edit]

  def check_authorization
    if current_user.present?
    end
  end

  def index
    @users = User.all
    if current_user.mechanic?
      redirect_to mechanic_booking_path
    elsif current_user.admin?
      redirect_to admins_path
    end
  end

  def show
    user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
    @user.build_address
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailerJob.perform_later(@user)
      # UserConfirmationMailer.user_confirmation_email(@user).deliver_now
      flash[:notice] = 'user added sucesfully!'
      redirect_to new_car_path
    else
      flash[:notice] = 'please check invalid password must include at least one uppercase letter, one lowecase letter, one digit, and one special character'
      render :new
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user.update(user_params)
      flash[:notice] = 'user updated!'
      redirect_to user_path
    else
      flash[:error] = 'Failed to edit user!'
      render :edit
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user.destroy
      flash[:notice] = 'deleted succesfully'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to delete !'   
      render :destroy   
    end   
  end

  private
  def user_params
    params.require(:user).permit(:id,:name, :email, :password,:contact, :role, address_attributes: [:id, :city,:location,:house_no,:user_id])
  end
end
