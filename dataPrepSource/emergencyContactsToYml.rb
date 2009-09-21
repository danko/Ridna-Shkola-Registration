require "rubygems"
require "faster_csv"
 

count = 0
FCSV.foreach( "parents.csv",
                   :headers           => true,
                   :header_converters => :symbol ) do |line|
                     

       STDOUT.write line[:lastname].capitalize + count.to_s
         puts ":"
         puts " userid:            " << line[:userid]
         puts " relationship:      " << line[:relationship]
         puts " lastname:          " << line[:lastname].capitalize
         puts " firstname:         " << line[:firstname].capitalize
       if line[:middlename]
         puts " middlename:        " << line[:middlename].capitalize
       else
         puts " middlename:"
       end
       if line[:dayphone]
         puts " dayphone:          " << line[:dayphone]
       else
         puts " dayphone: "
       end
       if line[:evephone]
         puts " evephone:          " << line[:evephone]
       else
         puts " evephone: "
       end
       if line[:cellphone]
         puts " cellphone:         " << line[:cellphone]
       else
         puts " cellphone: "
       end
         puts " email:             " << line[:email]
       if line[:profession]
         puts " profession:        " << line[:profession]
       else
         puts " profession: "
       end
       if line[:volunteerinterest]
         puts " volunteerinterest: " << line[:volunteerinterest]
       else
         puts " volunteerinterest: "
       end
       if line[:hobbies]
         puts " hobbies:           " << line[:hobbies] 
       else
         puts " hobbies: "
       end     
       puts
       puts
       count = count + 1
end
