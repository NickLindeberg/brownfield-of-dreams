prework_tutorial_data = {
  "title"=>"Back End Engineering - Prework",
  "description"=>"Videos for prework.",
  "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
  "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
  "classroom"=>false,
}
prework_tutorial = Tutorial.create! prework_tutorial_data

prework_tutorial.videos.create!({
  "title"=>"Prework - Environment Setup",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"qMkRHW9zE1c",
  "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
  "position"=>1
})
prework_tutorial.videos.create!({
  "title"=>"Prework - SSH Key Setup",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"XsPVWGKK0qI",
  "thumbnail"=>"https://i.ytimg.com/vi/XsPVWGKK0qI/hqdefault.jpg",
  "position"=>2
})
prework_tutorial.videos.create!({
  "title"=>"Prework - Strings",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"iXLwXvev4X8",
  "thumbnail"=>"https://i.ytimg.com/vi/iXLwXvev4X8/hqdefault.jpg",
  "position"=>3
})
prework_tutorial.videos.create!({
  "title"=>"Prework - Arrays",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"c2UnIQ3LRnM",
  "thumbnail"=>"https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg",
  "position"=>4
})


mod_1_tutorial_data = {
  "title"=>"Back End Engineering - Module 1",
  "description"=>"Videos related to Mod 1.",
  "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
  "playlist_id"=>"PL1Y67f0xPzdNsXqiJs1s4NlpI6ZMNdMsb",
  "classroom"=>true,
}

m1_tutorial = Tutorial.create! mod_1_tutorial_data

m1_tutorial.videos.create!({
  "title"=>"Flow Control in Ruby",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"tZDBWXZzLPk",
  "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
  "position"=>1
})
m1_tutorial.videos.create!({
  "title"=>"How to use SimpleCov",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"WMgDD2lU5nY",
  "thumbnail"=>"https://i.ytimg.com/vi/WMgDD2lU5nY/hqdefault.jpg",
  "position"=>2
})

mod_3_tutorial_data = {
  "title"=>"Back End Engineering - Module 3",
  "description"=>"Video content for Mod 3.",
  "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
  "playlist_id"=>"PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ",
  "classroom"=>false,
  "tag_list"=>["Internet", "BDD", "Ruby"],
}
m3_tutorial = Tutorial.create! mod_3_tutorial_data

m3_tutorial.videos.create!({
  "title"=>"Customizing JSON in your API",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"cv1VQ_9OqvE",
  "thumbnail"=>"https://i.ytimg.com/vi/cv1VQ_9OqvE/hqdefault.jpg",
  "position"=>1
})
m3_tutorial.videos.create!({
  "title"=>"Rails Integration Testing",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"J7ikFUlkP_k",
  "thumbnail"=>"https://i.ytimg.com/vi/J7ikFUlkP_k/hqdefault.jpg",
  "position"=>2
})
m3_tutorial.videos.create!({
  "title"=>"BEE - M3 - Building An Internal API",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"R5FPYQgB6Zc",
  "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
  "position"=>3
})
m3_tutorial.videos.create!({
  "title"=>"Stubbing External API Calls in Rails",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"FUYoJTtfJ20",
  "thumbnail"=>"https://i.ytimg.com/vi/FUYoJTtfJ20/hqdefault.jpg",
  "position"=>4
})
m3_tutorial.videos.create!({
  "title"=>"B3 - Making Fetch Happen",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"lqx4sD0E6eY",
  "thumbnail"=>"https://i.ytimg.com/vi/lqx4sD0E6eY/hqdefault.jpg",
  "position"=>5
})
m3_tutorial.videos.create!({
  "title"=>"BDD - Consuming an API",
  "description"=> Faker::Hipster.paragraph(2, true),
  "video_id"=>"FcgkfZEv_LI",
  "thumbnail"=>"https://i.ytimg.com/vi/FcgkfZEv_LI/hqdefault.jpg",
  "position"=>6
})

testing_tutorial_data = {
  "title"=>"Back End Engineering - Testing",
  "description"=>"Videos for Testing.",
  "thumbnail"=>"https://bento.cdn.pbs.org/hostedbento-prod/filer_public/PBS%20Parents%20Bob%20the%20Builder/episodes/episodes%20RGB%20Converted%20images/BTB_1001-Sky-High-Scoop-2_RGB-400px.jpg",
  "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
  "classroom"=>false,
}
testing_tutorial = Tutorial.create! testing_tutorial_data

admin = User.create!(email: 'admin@example.com', first_name: 'Bossy', last_name: 'McBosserton', password:  "password", role: :admin)
li_user = User.create!(email: 'user@example.com', first_name: 'user', last_name: 'userson', password: "password", role: :default, github_key: ENV["GITHUB_API_KEY"])
not_li_user2 = User.create!(email: 'user2@example.com', first_name: 'Mackenzie', last_name: 'Frey', password: "123", role: :default, handle: "Mackenzie-Frey")
not_li_user3 = User.create!(email: 'user3@example.com', first_name: 'Silver', last_name: 'McSilverson', password: "123", role: :default, handle: "SiCuellar")
not_li_user4 = User.create!(email: 'user4@example.com', first_name: 'User', last_name: 'Four', password: "123", role: :default)

Friendship.create(user_id: li_user.id, friend_id: not_li_user2.id)
