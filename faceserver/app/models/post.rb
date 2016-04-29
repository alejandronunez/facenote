class Post < ActiveRecord::Base
  belongs_to :profile
  has_many :comments, -> { order "created_at" }
end
