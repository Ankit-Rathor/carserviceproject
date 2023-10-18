class Booking < ApplicationRecord
  #scope
  default_scope {order('created_at DESC')}

  #enum
  enum :status, {confirmed: 'confirmed', pending: 'pending', cancelled: 'cancelled'}, default: :pending

  #Assosation
  belongs_to :user
  belongs_to :mechanic, class_name:'User', optional: true
  belongs_to :service, optional: true
  belongs_to :car

  #callback
  after_create :send_mail

  private
  def send_mail
    BookingMailer.new_booking_email(self).deliver_now
  end
end
