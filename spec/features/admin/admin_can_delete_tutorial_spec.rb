require 'rails_helper'

feature "Admin can delete a tutorial" do
  before :each do
    @admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    @tut_1 = create(:tutorial)
    create(:video, tutorial: @tut_1)
    create(:video, tutorial: @tut_1)
    create(:video, tutorial: @tut_1)

    @tut_2 = create(:tutorial)
    create(:video, tutorial: @tut_2)
    create(:video, tutorial: @tut_2)
  end
  it 'clicks delete tutorial on admin dashboard' do
    visit admin_dashboard_path
    expect(page).to have_css(".tutorial-links", count: 2)
    
    within "#tutorial-#{@tut_1.id}" do
      click_button "Delete"
    end

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Tutorial and videos have been deleted")
    expect(page).to have_css(".tutorial-links", count: 1)

    within "#tutorial-#{@tut_2.id}" do
      click_button "Delete"
    end

    expect(page).to_not have_css(".tutorial-links")
    expect(page).to have_content("Tutorial and videos have been deleted")
  end
  it 'destroys all videos for the destroyed tutorial' do
    visit admin_dashboard_path

    expect(Video.all.count).to eq(5)

    within "#tutorial-#{@tut_2.id}" do
      click_button "Delete"
    end

    expect(Video.all.count).to eq(3)
  end
end
