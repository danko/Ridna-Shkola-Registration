class Student < ActiveRecord::Base
  validates_presence_of     :lastname
  validates_presence_of     :firstname
  validates_presence_of     :gender
  validates_presence_of     :birthdate
  validates_presence_of     :newgrade
  validates_presence_of     :userid
  validates_presence_of     :studentid
  
  validates_uniqueness_of   :studentid
  
def create_teacher_display
  @family = User.find_by_userid(userid)
  out_string =  "<tr><td>" + lastname + 
                "</td><td>" + firstname +
                "</td><td>" + @family.email +
                "</td><td>" + @family.phonenum +
                "</td></tr>" 
  return out_string
end  
  
  
end
