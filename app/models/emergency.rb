class Emergency < ActiveRecord::Base
  validates_presence_of :lastname
  validates_presence_of :firstname
  validates_presence_of :dayphone
  validates_presence_of :evephone
end
