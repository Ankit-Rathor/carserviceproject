class UserConfirmationMailer < ApplicationMailer
    # default from: 'carservice@gmail.com'
    def user_confirmation_email(user)
      @user = user
      mail(to: @user.email, subject: 'welcome to car service app')
    end
end
