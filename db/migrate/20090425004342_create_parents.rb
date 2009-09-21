class CreateParents < ActiveRecord::Migration
  def self.up
    create_table :parents do |t|
      t.decimal :userid
      t.string :lastname
      t.string :firstname
      t.string :middlename
      t.string :relationship
      t.string :dayphone
      t.string :evephone
      t.string :cellphone
      t.string :email
      t.string :volunteerinterest
      t.string :profession
      t.string :hobbies

      t.timestamps
    end
  end

  def self.down
    drop_table :parents
  end
end
