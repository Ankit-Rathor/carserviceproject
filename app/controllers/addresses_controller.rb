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
  end
end
