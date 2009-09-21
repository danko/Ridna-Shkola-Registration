class CreateChecks < ActiveRecord::Migration
  def self.up
    create_table :checks do |t|
      t.decimal :userid
      t.decimal :checknumber
      t.decimal :amount
      t.date :updated_on

      t.timestamps
    end
  end

  def self.down
    drop_table :checks
  end
end
