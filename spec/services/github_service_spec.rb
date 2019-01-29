require 'rails_helper'

describe GithubService, type: :model do
  it 'exists' do
    service = GithubService.new(ENV["GITHUB_API_KEY"])
    expect(service).to be_a(GithubService)
  end
  describe 'instance methods' do
    context '#repos_owned' do
      it 'returns num of github repos for owner given valid key' do
        json_response = File.open('./spec/fixtures/github_owner_repos.json')
        stub_request(:get, "https://api.github.com/user/repos?affiliation=owner").to_return(status: 200, body: json_response)

        github_service = GithubService.new(ENV["GITHUB_API_KEY"])
        repos = github_service.repos_owned
        first = repos.first

        expect(repos.count).to eq(5)
        # expect(github_facade.repos(7).count).to eq(7)
        expect(first).to have_key(:id)
        expect(first).to have_key(:name)
        expect(first).to have_key(:full_name)
        expect(first).to have_key(:owner)
        expect(first).to have_key(:html_url)
        expect(first).to have_key(:description)
      end
    end
  end
end