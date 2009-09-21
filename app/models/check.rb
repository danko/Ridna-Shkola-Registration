class Check < ActiveRecord::Base
  
  validates_presence_of     :userid
  validates_presence_of     :amount
  validates_presence_of     :checknumber

end
