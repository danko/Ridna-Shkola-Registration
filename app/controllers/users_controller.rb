class UsersController < ApplicationController
  layout "registration", :except => [:print, :printUsers]
 
  before_filter :authorize, :except => [:new, :create, :reset, :resetPassword]
   
  
  # GET /users
  # GET /users.xml
  
  def reset  
  end
  
  def resetPassword
    @user = User.find_by_login(params[:name])
    if @user == nil
      @user = User.find_by_email(params[:name])
    end
    if @user == nil
      respond_to do |format|
          flash[:notice] = 'Your input did not match any account'
          format.html { render :action => "reset" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
    else
        @newPassword = @user.generate_password()
        @user.password = @newPassword
        @user.save
        email = PasswordMailer.deliver_forgot(@user, @newPassword)
        #render(:text => "<pre>" + email.encoded + "</pre>") 
        
        # This flash is for local registration on non-internet 
        #flash[:notice] = 'Your new password ' + @newPassword + ' has been emailed to: ' + @user.email
        
        flash[:notice] = 'Your new password has been emailed to: ' + @user.email

        # comment this redirect out to do local registration with emailed password
        #redirect_to(:controller => "admin", :action => "login_reset", :id => @user.id)      
    end
  end

  def index
    @current_user = User.find(session[:user_id])
    session[:other_user_id] = @current_user.userid
    
#    if @current_user[:admin]
#      @users = User.find(:all, :order => :family)
#   else
#      @users = [@current_user]
#    end

    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }

    end
  end
  
  def changePassword
    @user = User.find(session[:user_id])
    respond_to do |format|
    format.html # index.html.erb
    end   
  end
  
  def updatePassword
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Password was successfully changed.'
        format.html { redirect_to(@user, :action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "changePassword" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def register
    @current_user = get_other_user(session[:other_user_id])
    @calculated_amount_due = calculate_amount_due
    respond_to do |format|
      format.html # register.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def completeRegistration
    @current_user = get_other_user(session[:other_user_id])
    @current_students = Student.find_all_by_userid( @current_user.userid, :order => :firstname)

    #for student in @current_students
    #  student.registration_year = '2010-2011'
    #  student.save
    #end

    @current_user.amountdue = calculate_amount_due
    @current_user.amountpaid = 0
    @current_user.save
    redirect_to(@current_user)
  end
  
  def calculate_amount_due
    if @current_user.num_of_children_all == 1
      due = 625
    elsif @current_user.num_of_children_all == 2
      due = 875
    elsif @current_user.num_of_children_all >= 3
      due = 975
    else
      due = 0
    end
    deduct = @current_user.num_in_svitlychka * 400
    due = due - deduct
    if due < 0
      due = 0
    end
    return due
  end
      
#  def index
#    @current_user = User.find(session[:user_id])
#    if @current_user[:admin]
#      @users = User.find(:all, :order => :family)
#   else
#      @users = [@current_user]
#    end
#
#    respond_to do |format|
#    format.html # index.html.erb
#    format.xml  { render :xml => @users }
#
#    end
#  end
def output_yaml
  now = Time.now.to_date
  
  @users = User.find(:all, :order => :family)
  #outfile = "users" + now.to_s + ".yml"
  outfile = "users.yml"
  
  output = File.new(outfile, 'w')
  for user in @users
    x = user.to_yaml
    x = x.sub(/--- !ruby\/object:\w*\s*/,'')  
    x = x.sub(/attributes:/, user.family + user.userid.to_s + ":")
    output.puts x
  end
  output.close
  
  @students = Student.find(:all, :order => :lastname)
  outfile = "students.yml"
  output = File.new(outfile, 'w')
  for student in @students
    x = student.to_yaml
    x = x.sub(/--- !ruby\/object:\w*\s*/,'')  
    x = x.sub(/attributes:/, student.lastname + student.id.to_s + ":")
    output.puts x
  end  
  output.close
  
  @parents = Parent.find(:all, :order => :lastname)
  outfile = "parents.yml"
  output = File.new(outfile, 'w')
  for parent in @parents
    x = parent.to_yaml
    x = x.sub(/--- !ruby\/object:\w*\s*/,'')
    x = x.sub(/attributes:/, parent.lastname + parent.id.to_s + ":")
    output.puts x
  end
  output.close

  @emergencies = Emergency.find(:all, :order => :lastname)
  outfile = "emergencies.yml"
  output = File.new(outfile, 'w')
  for emergency in @emergencies
    x = emergency.to_yaml
    x = x.sub(/--- !ruby\/object:\w*\s*/,'')
    x = x.sub(/attributes:/, emergency.lastname + emergency.id.to_s + ":")
    output.puts x
  end  
  output.close

  @checks = Check.find(:all)
  outfile = "checks.yml"
  output = File.new(outfile, 'w')
  for check in @checks
    x = check.to_yaml
    x = x.sub(/--- !ruby\/object:\w*\s*/,'')
    x = x.sub(/attributes:/, "check" + check.id.to_s + check.userid.to_s + ":")
    output.puts x 
  end
  output.close

end


  def display
      @users = User.find(:all, :order => :family)
    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }

    end
  end

  def displayUsersThatOwe
      @users = User.find(:all, :order => :family)


    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }

    end
  end
  
  def displayRegisteredUsers
      @users = User.find(:all, :order => :family)

    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }

    end
  end  

  def displayEmails
      @users = User.find(:all, :order => :family)

    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }

    end
  end
  
  def generateMassEmailList
      @users = User.find(:all, :order => :family)

    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }

    end
  end

  def generateFullEmailList
      @users = User.find(:all, :order => :family)

    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }

    end
  end

  
  def printUsers
      @users = User.find(:all, :order => :family)

    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }

    end
  end

  
  def viewBilling
    # @global_user = User.find_by_userid(session[:user_id]) # user that logged in
    @current_user = User.find(params[:id]) # user whose record is being viewed
    

    #@current_user.amountpaid = amountpaid
    #@current_user.save
    
    #@current_user = User.find(session[:user_id])
    session[:other_user_id] = @current_user.userid
    
    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }
  end
end

  def addressbook
      @users = User.find(:all, :order => :family)
    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }

    end
  end

  def onlineaddressbook
    @users = User.find(:all, :conditions => ['onlineaddressbook = ?', true], :order => :family)
    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }
    end
  end

  def paperaddressbook
    @users = User.find(:all, :conditions => ['paperaddressbook = ?', true], :order => :family)
    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @current_user = User.find(params[:id])
    session[:other_user_id] = @current_user.userid

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def print
    @current_user = User.find(params[:id])
    session[:other_user_id] = @current_user.userid

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end  

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @current_user = User.find(session[:user_id])
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.admin = false
    
    tempusers = User.find(:all, :order => :userid)
    userid = 27
    for tempUser in tempusers do
      if tempUser.userid > userid
        userid = tempUser.userid
      end
    end
    @user.userid = userid + 1
    @user.family = @user.family.capitalize
   #if session[:user_id] == nil
    #  session[:user_id] = @user.id
    #  session[:other_user] = @user.id
    #end

    respond_to do |format|
      if @user.save
        if session[:user_id] == nil # a new user created from login panel
          flash[:notice] = "User was successfully created, please log in."
          #redirect_to :controller => :admin, :action => :login
          format.html { redirect_to(:controller => :admin, :action => :login) }
        else  # a new user created by an admin          
          flash[:notice] = 'User was successfully created.'
          format.html { redirect_to(:action=>:show, :id => @user.id) }
        end
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user, :action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def adminupdate
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated by admin.'
        format.html { redirect_to(:action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])

    @students = Student.find_all_by_userid(@user.userid)
    for student in @students
      student.destroy
    end
    @parents = Parent.find_all_by_userid(@user.userid)
    for parent in @parents
      parent.destroy
    end
    
    @contacts = Emergency.find_all_by_userid(@user.userid)
    for contact in @contacts
      contact.destroy
    end
    
    @checks = Check.find_all_by_userid(@user.userid)
    for check in @checks
      check.destroy
    end
    
    @user.destroy
    redirect_to :action => "display", :id => session[:user_id]
   # respond_to do |format|
      #format.html { redirect_to(users_url) }
    #  format.html { redirect_to(display) }
    #  format.xml  { head :ok }
   # end
  end

private

  def get_other_user(userid)
    current_user = User.find(session[:user_id])
    if current_user.admin || (current_user.userid == userid)
      other_user = User.find_by_userid(userid) # find the local user
      return other_user
    else
      return current_user
    end
  end    
end
