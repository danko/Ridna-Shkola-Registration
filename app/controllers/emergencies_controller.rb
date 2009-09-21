class EmergenciesController < ApplicationController
  layout "registration"

  # GET /emergencies
  # GET /emergencies.xml
  def index
    # This should never be called, just used for debugging
    @emergencies = Emergency.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @emergencies }
    end
  end

  # GET /emergencies/1
  # GET /emergencies/1.xml
  def show
    # This should never be called, just used for debugging
    @emergency = Emergency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @emergency }
    end
  end

  # GET /emergencies/new
  # GET /emergencies/new.xml
  def new
    @emergency = Emergency.new
    @other_user = User.find(params[:user][:id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @emergency }
    end
  end

  # GET /emergencies/1/edit
  def edit
    @emergency = Emergency.find(params[:id])
    @other_user = get_other_user(@emergency.userid) # set other_user to the userid that is being modified
  end

  # POST /emergencies
  # POST /emergencies.xml
  def create
    @emergency = Emergency.new(params[:emergency])

    # use userid from family account
    #if params[:id]
    #  current_user = User.find(params[:id])
    #else
    #  current_user = User.find(session[:user_id])
    #end
    #@emergency.userid = current_user.userid
    @other_user = get_other_user(@emergency.userid) # find the user for the added contact
    
    respond_to do |format|
      if @emergency.save
        flash[:notice] = 'Emergency was successfully created.'
        format.html { redirect_to(@other_user) }
        format.xml  { render :xml => @emergency, :status => :created, :location => @emergency }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @emergency.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /emergencies/1
  # PUT /emergencies/1.xml
  def update
    @local_userid = params[:id]
    @emergency = Emergency.find(@local_userid)
    @other_user = get_other_user(@emergency.userid) # find the user for the edited contact

    respond_to do |format|
      if @emergency.update_attributes(params[:emergency])
        flash[:notice] = 'Emergency was successfully updated.'
        format.html { redirect_to(@other_user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @emergency.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /emergencies/1
  # DELETE /emergencies/1.xml
  def destroy
    @emergency = Emergency.find(params[:id])
    @other_user = get_other_user(@emergency.userid)
    @emergency.destroy

    respond_to do |format|
      format.html { redirect_to(@other_user) }
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
