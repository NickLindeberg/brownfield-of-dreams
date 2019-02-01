require 'rails_helper'

describe GithubService, type: :model do
  it 'exists' do
    service = GithubService.new(ENV["GITHUB_API_KEY"])
    expect(service).to be_a(GithubService)
  end
  describe 'class methods' do
    context '.send_invite' do
      it "sends invite if user has email and returns boolean for sent status" do
        json_response = File.open('./spec/fixtures/github_user_email.json')
        stub_request(:get, "https://api.github.com/users/stoic-plus").to_return(status: 200, body: json_response)

        json_response = File.open('./spec/fixtures/github_user_no_email.json')
        stub_request(:get, "https://api.github.com/users/NickLindeberg").to_return(status: 200, body: json_response)

        sent = GithubService.send_invite('stoic-plus')

        expect(sent).to be_truthy
        open_email('ricardoledesmadev@gmail.com')
      end
    end
  end
  describe 'instance methods' do
    context '#owned_repos' do
      it 'returns github repos for owner given valid key' do
        json_response = File.open('./spec/fixtures/github_owner_repos.json')
        stub_request(:get, "https://api.github.com/user/repos?affiliation=owner").to_return(status: 200, body: json_response)

        github_service = GithubService.new(ENV["GITHUB_API_KEY"])
        repos = github_service.owned_repos
        first = repos.first

        expect(repos.count).to eq(30)
        expect(first).to have_key(:name)
        expect(first).to have_key(:full_name)
        expect(first).to have_key(:html_url)
        expect(first).to have_key(:description)
      end
    end
    context '#followers' do
      it 'returns followers for user given valid key' do
        json_response = File.open('./spec/fixtures/github_user_followers.json')
        stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: json_response)

        github_service = GithubService.new(ENV["GITHUB_API_KEY"])
        followers = github_service.followers
        first = followers.first

        expect(followers.count).to eq(9)
        expect(first).to have_key(:login)
        expect(first).to have_key(:html_url)
      end
    end
    context '#following' do
      it 'returns following users for user given valid key' do
        json_response = File.open('./spec/fixtures/github_user_following.json')
        stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: json_response)

        github_service = GithubService.new(ENV["GITHUB_API_KEY"])
        following = github_service.following
        first = following.first

        expect(following.count).to eq(3)
        expect(first).to have_key(:login)
        expect(first).to have_key(:html_url)
      end
    end
  end
end
