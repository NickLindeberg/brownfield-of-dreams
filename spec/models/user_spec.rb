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
    context '#bookmarks' do
      it 'returns a users bookmarks - all tutorial and video information (in order of tutorial title then video position)' do
        user = create(:user)
        tutorial = create(:tutorial, title: "How to Tie Your Shoes")
        video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)

        tutorial_2 = create(:tutorial, title: "How to Invade Russia")
        video_2 = create(:video, title: "Get a Sweater", tutorial: tutorial_2, position: 2)
        video_3 = create(:video, tutorial: tutorial_2, position: 1)

        Bookmarks.create(user_id: user.id, tutorial_id: tutorial.id, video_id: video.id)
        Bookmarks.create(user_id: user.id, tutorial_id: tutorial_2.id, video_id: video_2.id)

        user_bookmarks = user.bookmarks

        expect(user_bookmarks.first.title).to eq(tutorial_2.title)
        expect(user_bookmarks.first.description).to eq(tutorial_2.description)
        expect(user_bookmarks.first.thumbnail).to eq(tutorial_2.thumbnail)
        expect(user_bookmarks.first.playlist_id).to eq(tutorial_2.playlist_id)

        expect(user_bookmarks.first.videos.first.title).to eq(video_3.title)
        expect(user_bookmarks.first.videos.first.description).to eq(video_3.description)
        expect(user_bookmarks.first.videos.first.id).to eq(video_3.id)
        expect(user_bookmarks.first.videos.first.tutorial_id).to eq(video_3.tutorial_id)

        expect(user_bookmarks.first.videos.second.title).to eq(video_2.title)
        expect(user_bookmarks.first.videos.second.description).to eq(video_2.description)
        expect(user_bookmarks.first.videos.second.id).to eq(video_2.id)
        expect(user_bookmarks.first.videos.second.tutorial_id).to eq(video_2.tutorial_id)

        expect(user_bookmarks.second.title).to eq(tutorial.title)
        expect(user_bookmarks.second.description).to eq(tutorial.description)
        expect(user_bookmarks.second.thumbnail).to eq(tutorial.thumbnail)
        expect(user_bookmarks.second.playlist_id).to eq(tutorial.playlist_id)

        expect(user_bookmarks.second.videos.first.title).to eq(video.title)
        expect(user_bookmarks.second.videos.first.description).to eq(video.description)
        expect(user_bookmarks.second.videos.first.id).to eq(video.id)
        expect(user_bookmarks.second.videos.first.tutorial_id).to eq(video.tutorial_id)
      end
    end
  end
end
