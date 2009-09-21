class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.decimal :studentid
      t.decimal :userid
      t.string :lastname
      t.string :firstname
      t.string :middlename
      t.string :gender
      t.string :newgrade
      t.date :birthdate
      t.string :registration_year
      t.string  :allergies
      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
