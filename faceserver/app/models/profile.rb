class Profile < ActiveRecord::Base
  acts_as_liker
  belongs_to :user
  has_many :posts
  has_many :friendships
  has_many :friendships_to, :class_name => 'Friendship',:foreign_key => 'profile1_id'
  has_many :friends, -> { where 'friendships.state'=> 1 }, :class_name => 'Profile', through: :friendships, :source => :profile1

  has_one :image, as: :attachment
end
