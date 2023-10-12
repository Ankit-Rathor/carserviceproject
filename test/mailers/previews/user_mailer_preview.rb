class UserMailerPreview < ActionMailer::Preview
  def user_mail
      @user = User.find(user_id)
      mail = UsersMailer.welcome_email(user.id)
      mail.deliver_now

    mail(   :to      => @user.email,
            :subject => "Welcome"
    ) do |format|
      format.text
      format.html
    end
    # UserMailer.with(user: User.all.sample, fact: UserServices::User.new.user_fact).user_mail
  end
end
