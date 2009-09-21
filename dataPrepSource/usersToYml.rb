require "rubygems"
require "faster_csv"
require 'digest/sha1' 

def create_new_salt
  salt = self.object_id.to_s + rand.to_s
end

FCSV.foreach( "users.csv",
                   :headers           => true,
                   :header_converters => :symbol ) do |line|
                     
       salt = rand.to_s
       string_to_hash = line[:password] + "extrastuff" + salt
       hashed_password = Digest::SHA1.hexdigest(string_to_hash)
       STDOUT.write line[:login]
       puts ":"
       puts " login:       " << line[:login]
       puts " family:      " << line[:family].capitalize
       puts " userid:      " << line[:userid]
       puts " email:       " << line[:email]
       if line[:login] === "dnebesh" || line[:login] === "Shevchik"
         admin = true
       else
         admin = false
       end
       puts " admin:       " << admin.to_s
       puts " salt:        " << salt
       puts " hashed_password:    " << hashed_password
       puts " street:      " << line[:street]
       if line[:apt]
         puts " apt:         " << line[:apt]
       else
         puts " apt:"
       end
       puts " city:        " << line[:city].capitalize
       puts " state:       " << line[:state]
       puts " zip:         " << line[:zip]
       puts " phonenum:    " << line[:phonenum]
       puts " paperaddressbook:  false"
       puts " onlineaddressbook: false"
       puts
       puts
end
