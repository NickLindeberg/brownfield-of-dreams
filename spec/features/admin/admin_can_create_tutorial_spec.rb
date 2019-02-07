require 'rails_helper'

describe 'admin can create a tutorial' do

  before(:each) do
    @admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit '/admin/tutorials/new'
  end
  it 'saves tutorial and displays it' do
    fill_in "tutorial[title]", with: "How to bootstrap"
    fill_in "tutorial[description]", with: "Bootstrap is awesome"
    fill_in "tutorial[thumbnail]", with: "https://cdn.dribbble.com/users/32742/screenshots/4282422/bootstrap_category_page_principle_project.gif"
    click_on "Create Tutorial"

    tutorial = Tutorial.last
    video = create(:video, tutorial_id: tutorial.id)
    expect(current_path).to eq(tutorial_path(tutorial.id))
    expect(page).to have_content("Successfully created tutorial.")
  end

  it 'errors if missing title' do
    fill_in "tutorial[title]", with: ""
    fill_in "tutorial[description]", with: "Bootstrap is awesome"
    fill_in "tutorial[thumbnail]", with: "https://cdn.dribbble.com/users/32742/screenshots/4282422/bootstrap_category_page_principle_project.gif"
    click_on "Create Tutorial"

    tutorial = Tutorial.last
    expect(current_path).to eq(new_admin_tutorial_path)
    expect(page).to have_content("Missing information, please try again")
  end

  it 'errors if missing description' do
    fill_in "tutorial[title]", with: "How to bootstrap"
    fill_in "tutorial[description]", with: ""
    fill_in "tutorial[thumbnail]", with: "https://cdn.dribbble.com/users/32742/screenshots/4282422/bootstrap_category_page_principle_project.gif"
    click_on "Create Tutorial"

    tutorial = Tutorial.last
    expect(current_path).to eq(new_admin_tutorial_path)
    expect(page).to have_content("Missing information, please try again")
  end

  it 'errors if missing thumbnail' do
    fill_in "tutorial[title]", with: "How to bootstrap"
    fill_in "tutorial[description]", with: "Bootstrap is awesome"
    fill_in "tutorial[thumbnail]", with: ""
    click_on "Create Tutorial"

    tutorial = Tutorial.last
    expect(current_path).to eq(new_admin_tutorial_path)
    expect(page).to have_content("Missing information, please try again")
  end
end
