class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :hashed_password
      t.string :salt
      t.string :family
      t.string :email
      t.decimal :userid
      t.boolean :admin
      t.string  :street
      t.string  :city
      t.string  :state
      t.string  :zip
      t.string  :apt
      t.string  :phonenum
      t.boolean :paperaddressbook
      t.boolean :onlineaddressbook
      t.decimal :amountdue
      t.decimal :amountpaid

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
