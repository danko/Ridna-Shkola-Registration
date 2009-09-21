class TestController < ApplicationController
  def create_user
    user = User.find_by_family("Nebesh")
    email = PasswordMailer.create_forgot(user)
    render(:text => "<pre>" + email.encoded + "</pre>")
  end
end