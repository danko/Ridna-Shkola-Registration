# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "registration"
  
  before_filter :authorize, :except => [:login, :reset, :instructions, :contact] 

  session :session_key => '_registration_session_id'

  helper :all # include all helpers, all the time
  #self.allow_forgery_protection = false
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery :secret => 'e4106dc7a240fefa2fef3c9e1f0d561b'
  #protect_from_forgery :only => [:create, :update, :destroy]  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  protected
    def authorize
      unless User.find_by_id(session[:user_id])
        flash[:notice] = "Please log in"
        redirect_to :controller => :admin, :action => :login
      end
    end
  
end