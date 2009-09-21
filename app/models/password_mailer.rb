class PasswordMailer < ActionMailer::Base
  

  def forgot(user, newPassword)
    subject    'Ridna Shkola: Registration Account Update'
    recipients user.email
    from       'ridnashkola@243dan.magnus.hostingrails.com'
    sent_on    Time.now
    
    body       :user => user, :newPassword => newPassword
  end

end
