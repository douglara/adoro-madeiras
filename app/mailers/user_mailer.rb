class UserMailer < ApplicationMailer
  def notes_updated(user)
    @user = user
    mail(to: @user.email, subject: 'Suas notas no site da PUCPR foram atualizadas 💥')
  end
end
