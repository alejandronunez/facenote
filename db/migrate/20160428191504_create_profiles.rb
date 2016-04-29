class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :surname
      t.integer :age
      t.string :gender
      t.date :birday
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
