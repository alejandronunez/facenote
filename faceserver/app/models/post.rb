class Post < ActiveRecord::Base
  acts_as_likeable
  belongs_to :profile
  has_many :comments, -> { order "created_at" }
end
