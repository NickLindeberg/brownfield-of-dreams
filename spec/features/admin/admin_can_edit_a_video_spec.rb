require 'rails_helper'

describe 'admin can edit a video' do
  it 'updates video information' do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    tut_1 = create(:tutorial)
    create(:video, tutorial: tut_1)
    video = Video.last

    visit edit_admin_video_path(video.id)
    fill_in "video[title]", with: "Hello"
    fill_in "video[description]", with: "Moto"
    fill_in "video[thumbnail]", with: "Hello"
    click_on "Update Video"

    expect(current_path).to eq(admin_dashboard_path)
  end
end
