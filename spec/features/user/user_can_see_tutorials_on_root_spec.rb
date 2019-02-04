require 'rails_helper'

describe 'user sees all tutorials' do
  before(:each) do
    @tutorial_1 = create(:tutorial, classroom: false)
    @tutorial_2 = create(:tutorial, classroom: true)
    @tutorial_3 = create(:tutorial, classroom: false)
    @video_1 = create(:video, tutorial_id: @tutorial_1.id)
    @video_2 = create(:video, tutorial_id: @tutorial_2.id)

    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/'
  end

  it 'user can see all tutorials on root' do
    expect(page).to have_content(@tutorial_1.title)
    expect(page).to have_content(@tutorial_2.title)
  end

  it 'user can click on a tutorial and see the show page for classroom content' do
    click_on @tutorial_2.title

    expect(current_path).to eq(tutorial_path(@tutorial_2))
  end

  it 'user can click on a tutorial and see the show page for public content' do
    click_on @tutorial_1.title

    expect(current_path).to eq(tutorial_path(@tutorial_1))
  end
  it 'user does not see tutorial show if tutorial has no videos' do
    visit tutorial_path(@tutorial_3)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("That tutorial does not currently have videos")
  end
end
