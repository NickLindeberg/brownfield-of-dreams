require 'rails_helper'

describe 'Rendering Bookmarked Segments' do
  context 'as a logged in user - visiting /dashboard' do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @tutorial = create(:tutorial, title: "How to Tie Your Shoes")
      @video = create(:video, title: "The Bunny Ears Technique", tutorial: @tutorial)

      @tutorial_2 = create(:tutorial, title: "How to Invade Russia")
      @video_2 = create(:video, title: "Get a Sweater", tutorial: @tutorial_2, position: 2)
      @video_3 = create(:video, title: "Vodka", tutorial: @tutorial_2, position: 1)
      @video_4 = create(:video, title: "Russia invades you actually", tutorial: @tutorial_2)

      Bookmark.create(user_id: user.id, tutorial_id: @tutorial.id, video_id: @video.id)
      Bookmark.create(user_id: user.id, tutorial_id: @tutorial_2.id, video_id: @video_2.id)
      Bookmark.create(user_id: user.id, tutorial_id: @tutorial_2.id, video_id: @video_3.id)

      visit dashboard_path
    end
    it 'shows a list of all bookmarked segments under Bookmarked Segments' do
      within '.bookmarks' do
        expect(page).to have_content("Bookmarked Segments")
        expect(page).to have_css('.bookmark', count: 5)
        expect(page).to have_content("How to Tie Your Shoes")
        expect(page).to have_content("The Bunny Ears Technique")
        expect(page).to have_content("How to Invade Russia")
        expect(page).to have_content("Get a Sweater")
        expect(page).to have_content("Vodka")
      end
    end
    it 'shows a list of all bookmarked segments ordered by tutorial and position' do
      expect(all('.bookmark')[0]).to have_css("#tutorial-#{@tutorial_2.id}")
      expect(all('.bookmark')[1]).to have_css("#video-#{@video_3.id}")
      expect(all('.bookmark')[2]).to have_css("#video-#{@video_2.id}")
      expect(all('.bookmark')[3]).to have_css("#tutorial-#{@tutorial.id}")
      expect(all('.bookmark')[4]).to have_css("#video-#{@video.id}")

      expect(all('.tutorial')[0]).to have_content("#{@tutorial_2.title}")
      expect(all('.tutorial')[1]).to have_content("#{@tutorial.title}")
      expect(all('.video')[0]).to have_content("Segment: #{@video_3.title}")
      expect(all('.video')[1]).to have_content("Segment: #{@video_2.title}")
      expect(all('.video')[2]).to have_content("Segment: #{@video.title}")

      expect(page).to_not have_content("#{@video_4.title}")
      expect(page).to_not have_css("#video-#{@video_4.id}")
    end
    it 'links to tutorial path for video through video name' do
      expect(page).to have_link("#{@video.title}", href: "/tutorials/#{@tutorial.id}?video_id=#{@video.id}")
      click_link "#{@video.title}"
      expect(current_url).to eq("http://www.example.com#{tutorial_path(@tutorial.id, video_id: @video.id)}")

      visit dashboard_path
      expect(page).to have_link("#{@video_2.title}", href: "/tutorials/#{@tutorial_2.id}?video_id=#{@video_2.id}")
      click_link "#{@video_2.title}"
      expect(current_url).to eq("http://www.example.com#{tutorial_path(@tutorial_2.id, video_id: @video_2.id)}")

      visit dashboard_path
      expect(page).to have_link("#{@video_3.title}", href: "/tutorials/#{@tutorial_2.id}?video_id=#{@video_3.id}")
      click_link "#{@video_3.title}"
      expect(current_url).to eq("http://www.example.com#{tutorial_path(@tutorial_2.id, video_id: @video_3.id)}")
    end
  end
end
