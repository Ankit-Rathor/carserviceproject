class BookingConfirmationMailer < ApplicationMailer
  default from: 'yogeshpatidar@gmail.com'
  def booking_confirmation_email(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'confirm your booking succesfully')
  end
end
