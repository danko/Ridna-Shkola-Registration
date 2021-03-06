class ChecksController < ApplicationController
    layout "registration"
    
  # GET /checks
  # GET /checks.xml
  def index
    @checks = Check.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checks }
    end
  end

  # GET /checks/1
  # GET /checks/1.xml
  def show
    @check = Check.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @check }
    end
  end

  # GET /checks/new
  # GET /checks/new.xml
  def new
    @check = Check.new
    @current_user = User.find(params[:user][:id]) # selected user

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @check }
    end
  end

  # GET /checks/1/edit
  def edit
    @check = Check.find(params[:id])
  end

  # POST /checks
  # POST /checks.xml
  def create
    @check = Check.new(params[:check])
    @other_user = get_other_user(@check.userid) # find the user for the added contact
    
    # use userid from family account
    #current_user = User.find_by_userid(session[:other_user_id])
    #@check.userid = session[:other_user_id]

    
    respond_to do |format|
      if @check.save
        flash[:notice] = 'Check was successfully created.'
        format.html { redirect_to :controller => '/users', :action => 'displayUsersThatOwe', :id => @other_user.id  }
        format.xml  { render :xml => @check, :status => :created, :location => @check }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @check.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /checks/1
  # PUT /checks/1.xml
  def update
    @check = Check.find(params[:id])
    current_user = User.find_by_userid(session[:other_user_id])

    #current_user = User.find(session[:user_id])
    #current_user.amountpaid = current_user.amountpaid - @check.amount
    respond_to do |format|
      if @check.update_attributes(params[:check])
        current_user.amountpaid = current_user.amountpaid + @check.amount
        current_user.save
        flash[:notice] = 'Check was successfully updated.'
        format.html { redirect_to :controller => '/users', :action => 'viewBilling', :id => current_user.id }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @check.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /checks/1
  # DELETE /checks/1.xml
  def destroy
    @check = Check.find(params[:id])
    
    current_user = get_other_user(session[:other_user_id])
    @check.destroy
    respond_to do |format|
      format.html { redirect_to :controller => '/users', :action => 'displayUsersThatOwe', :id => current_user.id }
      format.xml  { head :ok }
    end
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
