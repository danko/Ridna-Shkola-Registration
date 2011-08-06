
class PasswordMailer < ActionMailer::Base
  

  def forgot(user, newPassword)
    subject    'Ridna Shkola: Registration Account Update'
    recipients user.email
#    recipients 'danko1@gmail.com'
#    from       'ridnashkola@243dan.magnus.hostingrails.com'
    from       'danko1@gmail.com'
    sent_on    Time.now
    
    body       :user => user, :newPassword => newPassword
  end

end
