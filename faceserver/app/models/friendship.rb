class Friendship < ActiveRecord::Base
  belongs_to :profile
  belongs_to :profile1, class_name: 'Profile', foreign_key: 'profile1_id'
end
