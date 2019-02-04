require 'rails_helper'

describe 'User can add friends' do
  before :each do
    json_response = File.open('./spec/fixtures/github_owner_repos.json')
    stub_request(:get, "https://api.github.com/user/repos?affiliation=owner").to_return(status: 200, body: json_response)

    json_response = File.open('./spec/fixtures/github_user_followers.json')
    stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: json_response)

    json_response = File.open('./spec/fixtures/github_user_following.json')
    stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: json_response)

    @user = create(:user, first_name: "noahlinc", github_key: ENV["GITHUB_API_KEY"])
    @user_2 = create(:user, first_name: "link", handle: "iandouglas")
    @user_3 = create(:user, first_name: "new", handle: "NickLindeberg")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/dashboard'
  end
  it 'shows link next to following to add them as a friend' do
    within(".following") do
      click_on "Add Friend"
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Friend Added")
  end
  it 'shows link next to followers to add them as a friend' do
    within(".followers") do
      click_on "Add Friend"
    end
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Friend Added")
  end
end
