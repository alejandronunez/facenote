class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :profile_id
      t.integer :profile1_id

      t.timestamps null: false
    end
  end
end
