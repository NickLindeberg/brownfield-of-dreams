class UserActivateMailer < ApplicationMailer

  def activate(user)
    @user = user
    mail(to: user[:email], subject: "Please Activate Your Account!")
  end

end
