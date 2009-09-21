require "rubygems"
require "faster_csv"
 

count = 0
FCSV.foreach( "students.csv",
                   :headers           => true,
                   :header_converters => :symbol ) do |line|
                     

       STDOUT.write line[:lastname].capitalize + count.to_s
       puts ":"
       puts " userid:       " << line[:userid]
       puts " studentid:    " << line[:studentid]
       puts " lastname:     " << line[:lastname].capitalize
       puts " firstname:    " << line[:firstname].capitalize
       if line[:middlename]
         puts " middlename:   " << line[:middlename].capitalize
       else
         puts " middlename:"
       end
       puts " gender:       " << line[:gender].capitalize
       puts " newgrade:     " << line[:newgrade]
       puts " birthdate:    " << line[:birthdate]
       puts " registration_year: 2008-2009"
       puts
       puts
       count = count + 1
end
