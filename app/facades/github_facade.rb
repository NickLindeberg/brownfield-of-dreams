class GithubFacade
  def initialize(github_key, current_user)
    @github_key = github_key
    @user = current_user
  end

  def owned_repos(num=5)
    repos = []
    service.owned_repos.each_with_index do |raw_repo, i|
      repos << Repo.new(raw_repo)
      break if i == num - 1
    end
    repos
  end

  def followers
    generate_github_users(service.followers)
  end

  def following
    generate_github_users(service.following)
  end

  def already_friends?(handle)
    @user.friends.include?(User.find_by(handle: handle))
  end

  def user_in_system?(handle)
    u = User.find_by(handle: handle)
  end

  def service
    x = GithubService.new(@github_key)
  end

  private

  def generate_github_users(json)
    json.map do |attributes|
      GithubUser.new(attributes)
    end
  end
end
