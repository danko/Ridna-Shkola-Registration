require 'digest/sha1'


class User < ActiveRecord::Base
  
  validates_presence_of     :login
  validates_presence_of     :email
  validates_presence_of     :family
  validates_presence_of     :login
  validates_uniqueness_of   :login
  validates_uniqueness_of   :userid
  validates_uniqueness_of   :email
 
  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank
  
  validates_presence_of     :street
  validates_presence_of     :city
  validates_presence_of     :state
  validates_presence_of     :zip
  validates_presence_of     :phonenum
  
  def self.authenticate(name, password)
    if name == nil || password == nil
      return nil
    end
    user = User.find_by_login(name) # find user using login account
    if user == nil
      #name = name.capitalize
      user = User.find_by_email(name) # find user by last name
    end
    
 #   user = User.find(:first, :conditions => ["name=?", name]);
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

def updateRegistration
  current_students = Student.find_all_by_userid(userid)

  for student in current_students
    student.registration_year = '2009-2010'
    student.save
  end
end


  def num_of_children_all
    children = Student.find_all_by_userid(userid)
    return children.length
  end

  def num_of_children
    children = Student.find_all_by_userid(userid, :conditions => "registration_year='2009-2010'")
    return children.length
  end
  
  def num_in_svitlychka
    children = Student.find_all_by_userid(userid, :conditions => "newgrade = 'Svitlychka' and registration_year='2009-2010'")
    return children.length
  end

  def num_in_svitlychka_all
    children = Student.find_all_by_userid(userid, :conditions => "newgrade = 'Svitlychka'")
    return children.length
  end
  
  def balance
    if amountdue && amountpaid
      return amountdue - amountpaid
    else
      return 0
    end
  end
  
  # 'password' is a virtual attribute
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def calc_amountpaid
    paid = 0
      if userid
      checks = Check.find_all_by_userid(userid)
      if checks != nil
        for check in checks
          if check != nil
            paid = paid + check.amount
          end
        end 
      end
    end
    return paid
  end

  def calc_amount_due
    num_childs = num_of_children
    if num_childs == 1
      due = 625
    elsif num_childs == 2
      due = 875
    elsif num_childs >= 3
      due = 975
    else
      due = 0
    end
    deduct = num_in_svitlychka * 400
    due = due - deduct
    if num_childs == num_in_svitlychka
      due = 0
    end
    if due < 0
      due = 0
    end
    return due
  end   
  
  def calc_balance
    return calc_amount_due - calc_amountpaid
  end 

  def generate_password(length = 8)
     chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('1'..'9').to_a - ['o', 'O', 'i', 'I']
     Array.new(length) { chars[rand(chars.size)] }.join
  end

private

  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end

  
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "extrastuff" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end



end
