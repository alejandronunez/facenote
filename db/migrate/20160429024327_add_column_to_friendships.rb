class AddColumnToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :state, :integer
  end
end
