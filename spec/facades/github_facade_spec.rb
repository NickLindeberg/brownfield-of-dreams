require 'rails_helper'

describe GithubFacade, type: :model do
  it 'exists' do
    user = create(:user)
    github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"], user)
    expect(github_facade).to be_a(GithubFacade)
  end

  describe 'instance methods' do
    context '#owned_repos' do
      it 'returns num of repos for user given valid key' do
        user = create(:user)
        json_response = File.open('./spec/fixtures/github_owner_repos.json')
        stub_request(:get, "https://api.github.com/user/repos?affiliation=owner").to_return(status: 200, body: json_response)
        github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"], user)

        repos = github_facade.owned_repos(5)
        expect(repos.count).to eq(5)
        expect(repos.first).to be_a(Repo)

        repos = github_facade.owned_repos(10)
        expect(repos.count).to eq(10)
        expect(repos.first).to be_a(Repo)
      end
    end
    context '#followers' do
      it 'returns followers for a user given valid key' do
        user = create(:user)
        json_response = File.open('./spec/fixtures/github_user_followers.json')
        stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: json_response)
        github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"], user)

        followers = github_facade.followers
        expect(followers.count).to eq(9)
        expect(followers.first).to be_a(GithubUser)
      end
    end
    context '#following' do
      it 'returns following users for a user given valid key' do
        user = create(:user)
        json_response = File.open('./spec/fixtures/github_user_following.json')
        stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: json_response)
        github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"], user)

        following = github_facade.following
        expect(following.count).to eq(3)
        expect(following.first).to be_a(GithubUser)
      end
    end

    context '#already_friends?' do
      it 'shows a user that is connected on github and is in our system' do
        user = create(:user)
        user_2 = create(:user, handle: "iandouglas")
        friendship = Friendship.create(user_id: user.id, friend_id: user_2.id)
        json_response = File.open('./spec/fixtures/github_user_following.json')
        stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: json_response)
        github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"], user)

        friends = github_facade.already_friends?(user_2.handle)
        expect(friends).to be(true)
      end
    end

    context '#user_in_system?' do
      it 'shows a user that is connected on github and is in our system' do
        user = create(:user)
        user_2 = create(:user, handle: "iandouglas")
        json_response = File.open('./spec/fixtures/github_user_following.json')
        stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: json_response)
        github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"], user)

        user = github_facade.user_in_system?(user_2.handle)
        expect(user.id).to be(user_2.id)
      end
    end
  end
end
