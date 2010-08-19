class StudentsController < ApplicationController
  layout "registration"
  
  # GET /students
  # GET /students.xml
  def index
    @students = Student.find(:all, :order => :lastname)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  def displayNewStudents
    @students = Student.find(:all, :conditions => "registration_year = '2010-2011'", :order => :lastname)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end 

  def displayStudentBody
    @students = Student.find(:all, :conditions => "registration_year = '2010-2011'", :order => :newgrade)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  def displayOldClasses
    #@students = Student.find(:all, :order => :newgrade)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end  
  def displayNewClasses
    #@students = Student.find(:all, :conditions => "registration_year = '2010-2011'", :order => :newgrade)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  
  def teacherDisplayClasses
    #@students = Student.find(:all, :conditions => "registration_year = '2009-2010'", :order => :newgrade)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  
  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new
    @other_user = User.find(params[:user][:id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
    #@other_user = get_other_user(@student.userid) # set other_user to the userid that is being modified 
  end

  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])
    #@student.userid = session[:other_user_id]
    @student.registration_year = '2010-2011'
    @other_user = get_other_user(@student.userid) # find the user for the added contact
    
    #@other_user = get_other_user(session[:other_user_id]) 
    @students = Student.find(:all)    
    studentid = 100
      for tempStudent in @students do
        if tempStudent.studentid > studentid
          studentid = tempStudent.studentid
        end
      end
    @student.studentid = studentid + 1
    @student.lastname = @student.lastname.capitalize
    @student.firstname = @student.firstname.capitalize
    if @student.middlename
      @student.middlename = @student.middlename.capitalize
    end

    respond_to do |format|
      if @student.save
        flash[:notice] = 'Student was successfully created.'
        format.html { redirect_to(@other_user) }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])
       @student.registration_year = '2010-2011'
    @other_user = get_other_user(session[:other_user_id]) # find the user for the edited contact


    respond_to do |format|
     if @student.update_attributes(params[:student])
 #     if @student.save
        flash[:notice] = 'Student was successfully registered/updated.'
        format.html { redirect_to(@other_user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @other_user = get_other_user(@student.userid)

    @student.destroy

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
