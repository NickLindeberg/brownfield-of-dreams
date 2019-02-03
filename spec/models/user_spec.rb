require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end
  describe 'instance methods' do
    context '#bookmarked_segments' do
      it 'returns a users bookmarks - all tutorial and video information (in order of tutorial title then video position)' do
        user = create(:user)
        tutorial = Tutorial.create(title: "How to Tie Your Shoes",
                                   description: Faker::HitchhikersGuideToTheGalaxy.marvin_quote,
                                   thumbnail: "sdk",
                                   playlist_id: Faker::Crypto.md5,
                                   classroom: false,
                                   created_at: Time.now,
                                   updated_at: Time.now
                                 )
        video = Video.create(title: "The Bunny Ears Technique",
                             description: Faker::SiliconValley.motto,
                             video_id: Faker::Crypto.md5,
                             thumbnail: "sdahdskahds",
                             tutorial_id: tutorial.id,
                             position: 0
                           )

       tutorial_2 = Tutorial.create(title: "How to Invade Russia",
                                  description: Faker::HitchhikersGuideToTheGalaxy.marvin_quote,
                                  thumbnail: "sddasdadadsa",
                                  playlist_id: Faker::Crypto.md5,
                                  classroom: false,
                                  created_at: Time.now,
                                  updated_at: Time.now
                                )
       video_2 = Video.create(title: "Get a Sweater",
                            description: Faker::SiliconValley.motto,
                            video_id: Faker::Crypto.md5,
                            thumbnail: "slllllllhds",
                            tutorial_id: tutorial_2.id,
                            position: 2
                          )
       video_3 = Video.create(title: Faker::Pokemon.name,
                           description: Faker::SiliconValley.motto,
                           video_id: Faker::Crypto.md5,
                           thumbnail: "kjdjjdjdj",
                           tutorial_id: tutorial_2.id,
                           position: 1
                         )
       video_4 = Video.create(title: Faker::Pokemon.name,
                           description: Faker::SiliconValley.motto,
                           video_id: Faker::Crypto.md5,
                           thumbnail: "kjdjjdjdj",
                           tutorial_id: tutorial_2.id,
                           position: 3
                         )

        Bookmark.create(user_id: user.id, tutorial_id: tutorial.id, video_id: video.id)
        Bookmark.create(user_id: user.id, tutorial_id: tutorial_2.id, video_id: video_2.id)
        Bookmark.create(user_id: user.id, tutorial_id: tutorial_2.id, video_id: video_3.id)

        user_bookmarks = user.bookmarked_segments

        expect(user_bookmarks.first.tut_id).to eq(tutorial_2.id)
        expect(user_bookmarks.first.tut_title).to eq(tutorial_2.title)
        expect(user_bookmarks.first.tut_desc).to eq(tutorial_2.description)
        expect(user_bookmarks.first.tut_thumbnail).to eq(tutorial_2.thumbnail)

        expect(user_bookmarks.first.title).to eq(video_3.title)
        expect(user_bookmarks.first.description).to eq(video_3.description)
        expect(user_bookmarks.first.id).to eq(video_3.id)
        expect(user_bookmarks.first.tutorial_id).to eq(video_3.tutorial_id)

        expect(user_bookmarks.second.tut_id).to eq(tutorial_2.id)
        expect(user_bookmarks.second.tut_title).to eq(tutorial_2.title)
        expect(user_bookmarks.second.tut_desc).to eq(tutorial_2.description)
        expect(user_bookmarks.second.tut_thumbnail).to eq(tutorial_2.thumbnail)

        expect(user_bookmarks.second.title).to eq(video_2.title)
        expect(user_bookmarks.second.description).to eq(video_2.description)
        expect(user_bookmarks.second.id).to eq(video_2.id)
        expect(user_bookmarks.second.tutorial_id).to eq(video_2.tutorial_id)

        expect(user_bookmarks.third.tut_id).to eq(tutorial.id)
        expect(user_bookmarks.third.tut_title).to eq(tutorial.title)
        expect(user_bookmarks.third.tut_desc).to eq(tutorial.description)
        expect(user_bookmarks.third.tut_thumbnail).to eq(tutorial.thumbnail)

        expect(user_bookmarks.third.title).to eq(video.title)
        expect(user_bookmarks.third.description).to eq(video.description)
        expect(user_bookmarks.third.id).to eq(video.id)
        expect(user_bookmarks.third.tutorial_id).to eq(video.tutorial_id)
      end
    end
  end
end
