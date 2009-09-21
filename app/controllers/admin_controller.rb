class AdminController < ApplicationController
  layout "registration"
  # just display the form and wait for user to
  # enter a name and password
  
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        user.updateRegistration
        session[:other_user_id] = user.id
        redirect_to(:controller => "users", :action => "index")
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end
  
  def contact
  end
  
  def instructions
  end
  
  def logout
    session[:user_id] = nil
    session[:other_user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

def login_reset
  flash.now[:notice] = "Your new password has been emailed."
end


  
def getAccount
  
end
  
  def index
      redirect_to(:action => "login") 
  end
  


  def reset_password
     if request.post?
        user = User.find_by_family(params[:family])
        if user
           new_password = generate_password()
           user.password=new_password
           user.save
           PasswordNotification.deliver_password(user, new_password)
           flash[:notice] = "New password has been mailed to #{params[:email]}."
        else
           flash[:notice] = "The information you provided does not match our records"
        end
     end
     redirect_to :controller => 'login', :action => 'login' and return
  end

  private

  def generate_password(length = 8)
     chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('1'..'9').to_a - ['o', 'O', 'i', 'I']
     Array.new(length) { chars[rand(chars.size)] }.join
  end
  
end



