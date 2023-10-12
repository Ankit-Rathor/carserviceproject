class UserMailerJob < ApplicationJob
  queue_as :default

  def perform(user)
    binding.pry
    UserMailer.welcome_email(user).deliver_now
    # User.find_each do |user|
    # UserMailer.with(user: user, fact: UserServices::User.new.daily_fact).user_mail.deliver_now
    # puts "hello world"
  end
end
