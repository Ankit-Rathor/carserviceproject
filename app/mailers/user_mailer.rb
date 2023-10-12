class UserMailer < ApplicationMailer
  def welcome_email(user)
    binding.pry
    @user = user
    mail(to: @user.email, subject: "User mail!")
  end
end
