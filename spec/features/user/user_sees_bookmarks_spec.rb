# As a logged in user
# When I visit '/dashboard'
# Then I should see a list of all bookmarked segments under the Bookmarked Segments section
# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position

require 'rails_helper'

describe 'Rendering Bookmarked Segments' do
  context 'as a logged in user - visiting /dashboard' do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @tutorial = create(:tutorial, title: "How to Tie Your Shoes")
      @video = create(:video, title: "The Bunny Ears Technique", tutorial: @tutorial)

      @tutorial_2 = create(:tutorial, title: "How to Invade Russia")
      @video_2 = create(:video, title: "Get a Sweater", tutorial: @tutorial_2)

      UserVideo.create(user_id: user.id, video_id: @video.id)
      UserVideo.create(user_id: user.id, video_id: @video_2.id)

      visit dashboard_path
    end
    it 'shows a list of all bookmarked segments under Bookmarked Segments' do
      expect(page).to have_content("Bookmarked Segments")

      within '.bookmarks' do
        expect(page).to have_css('.bookmark', count: 2)
        expect(page).to have_content("The Bunny Ears Technique")
        expect(page).to have_content("Get a Sweater")
      end
    end
    it 'shows a list of bookmarked segments organized by tutorial' do
      within '.bookmarks' do
        within "#tutorial-#{@tutorial.id}" do
          expect(page).to have_css("#video-#{@video.id}")
          expect(page).to have_content("The Bunny Ears Technique")
        end
        within "#tutorial-#{@tutorial_2.id}" do
          expect(page).to have_css("#video-#{@video_2.id}")
          expect(page).to have_content("Get a Sweater")
        end
      end
    end
    it 'shows a list of all bookmarked segments ordered by position' do
      expect(all('.tutorial')[0]).to have_content("How to Tie Your Shoes")
      expect(all('.tutorial')[1]).to have_content("How to Invade Russia")

      expect(all('.video')[0]).to have_content("The Bunny Ears Technique")
      expect(all('.video')[1]).to have_content("Get a Sweater")
    end
  end
end
