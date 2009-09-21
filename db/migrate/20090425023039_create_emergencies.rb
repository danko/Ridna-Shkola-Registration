class CreateEmergencies < ActiveRecord::Migration
  def self.up
    create_table :emergencies do |t|
      t.decimal :userid
      t.string :lastname
      t.string :firstname
      t.string :dayphone
      t.string :evephone
      t.string :cellphone
      t.string :relationship

      t.timestamps
    end
  end

  def self.down
    drop_table :emergencies
  end
end
