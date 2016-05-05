# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Profile.destroy_all
c = Profile.create(:firstname => 'Carlos',:surname =>'Morales',:age => 27 ,:gender => 'Masculino')
r = Profile.create(:firstname => 'Reinier',:surname =>'Ruiz',:age => 29 ,:gender => 'Masculino')
l = Profile.create(:firstname => 'Leo',:surname =>'Masmejor',:age => 28 ,:gender => 'Masculino')
a = Profile.create(:firstname => 'Analay',:surname =>'Murle',:age => 28 ,:gender => 'Femenino')
a2 = Profile.create(:firstname => 'Alejandro',:surname =>'Nunez',:age => 28 ,:gender => 'Masculino')
Friendship.destroy_all
Friendship.create(:profile => c , :profile1=> r, :state => 1)
Friendship.create(:profile => c , :profile1=> l, :state => 1)
Friendship.create(:profile => l , :profile1=> c, :state => 1)
Friendship.create(:profile => l , :profile1=> a, :state => 1)
Friendship.create(:profile => r , :profile1=> c, :state => 1)
Friendship.create(:profile => a , :profile1=> l, :state => 1)
Friendship.create(:profile => a2 , :profile1=> c, :state => 0)
Friendship.create(:profile => c , :profile1=> a, :state => 0)
Post.destroy_all
p1 = Post.create(:message => 'Hi Facenote. I happy',:profile=>c)
p2 = Post.create(:message => 'Hi Facenote. I happy',:profile=>r)
p3 = Post.create(:message => 'Hi Facenote. I happy',:profile=>l)
p4 = Post.create(:message => 'Hi Facenote. I happy',:profile=>a)
p5 = Post.create(:message => 'Good day to play',:profile=>c)
p6 = Post.create(:message => 'Good day to play',:profile=>a)
p7 = Post.create(:message => 'Good day to play',:profile=>l)
Comment.destroy_all
Comment.create(:message => 'You are foolish',:profile=>l,:post => p2)
Comment.create(:message => 'You are foolish',:profile=>r,:post => p1)
Comment.create(:message => 'You are foolish',:profile=>a,:post => p3)
Comment.create(:message => 'You are foolish * 2',:profile=>c,:post => p2)
Comment.create(:message => 'You are foolish',:profile=>c,:post => p7)