# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090828013938) do

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "booktype"
    t.string   "grade"
    t.boolean  "required"
    t.decimal  "price"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checks", :force => true do |t|
    t.decimal  "userid"
    t.decimal  "checknumber"
    t.decimal  "amount"
    t.date     "updated_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emergencies", :force => true do |t|
    t.decimal  "userid"
    t.string   "lastname"
    t.string   "firstname"
    t.string   "dayphone"
    t.string   "evephone"
    t.string   "cellphone"
    t.string   "relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parents", :force => true do |t|
    t.decimal  "userid"
    t.string   "lastname"
    t.string   "firstname"
    t.string   "middlename"
    t.string   "relationship"
    t.string   "dayphone"
    t.string   "evephone"
    t.string   "cellphone"
    t.string   "email"
    t.string   "volunteerinterest"
    t.string   "profession"
    t.string   "hobbies"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "students", :force => true do |t|
    t.decimal  "studentid"
    t.decimal  "userid"
    t.string   "lastname"
    t.string   "firstname"
    t.string   "middlename"
    t.string   "gender"
    t.string   "newgrade"
    t.date     "birthdate"
    t.string   "registration_year"
    t.string   "allergies"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "family"
    t.string   "email"
    t.decimal  "userid"
    t.boolean  "admin"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "apt"
    t.string   "phonenum"
    t.boolean  "paperaddressbook"
    t.boolean  "onlineaddressbook"
    t.decimal  "amountdue"
    t.decimal  "amountpaid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
