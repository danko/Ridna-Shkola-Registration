class ParentsController < ApplicationController
  layout "registration"
  
  # GET /parents
  # GET /parents.xml
  def index
    @parents = Parent.find(:all, :order => :lastname)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parents }
    end
  end

  # GET /parents/1
  # GET /parents/1.xml
  def show
    @parent = Parent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @parent }
    end
  end

  # GET /parents/new
  # GET /parents/new.xml
  def new
    @parent = Parent.new
    @other_user = User.find(params[:user][:id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @parent }
    end
  end

  # GET /parents/1/edit
  def edit
    @parent = Parent.find(params[:id])
    @other_user = get_other_user(@parent.userid) # set other_user to the userid that is being modified

  end

  # POST /parents
  # POST /parents.xml
  def create
    @parent = Parent.new(params[:parent])
    @other_user = get_other_user(@parent.userid) 
    # use userid from family account
    
    respond_to do |format|
      if @parent.save
        flash[:notice] = 'Parent was successfully created.'
        format.html { redirect_to(@other_user) }
        format.xml  { render :xml => @parent, :status => :created, :location => @parent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @parent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /parents/1
  # PUT /parents/1.xml
  def update
    @local_userid = params[:id]
    @parent = Parent.find(@local_userid)
    @other_user = get_other_user(@parent.userid) # find the user for the edited contact
    
    respond_to do |format|
      if @parent.update_attributes(params[:parent])
        flash[:notice] = 'Parent was successfully updated.'
        format.html { redirect_to(@other_user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @parent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /parents/1
  # DELETE /parents/1.xml
  def destroy
    @parent = Parent.find(params[:id])
    @other_user = get_other_user(@parent.userid)
    @parent.destroy

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
