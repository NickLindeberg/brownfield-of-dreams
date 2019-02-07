class GithubService
  attr_reader :github_key

  def initialize(github_key)
    @github_key = github_key
  end

  def self.send_invite(from_user, github_handle)
    user_info = self.get_user_info(github_handle, from_user.github_key)
    return false unless user_info[:email]
    GithubInviterMailer.invite(from_user, GithubUser.new(user_info)).deliver_now
    true
  end

  def self.get_user_info(github_handle, github_key)
    get_json("/users/#{github_handle}", github_key)
  end

  def owned_repos
    get_json("/user/repos?affiliation=owner")
  end

  def followers
    get_json("/user/followers")
  end

  def following
    get_json("/user/following")
  end

  def get_json(url)
    response = authenticated_conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_json(path, github_key)
    response = unauthenticated_conn.get do |req|
      req.url path, :access_token => github_key
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def authenticated_conn
    Faraday.new(:url => "https://api.github.com") do |faraday|
     faraday.headers["Accept"] = "application/vnd.github.v3+json"
     faraday.headers["Authorization"] = "token #{@github_key}"
     faraday.adapter Faraday.default_adapter
    end
  end

  def self.unauthenticated_conn
    Faraday.new(:url => "https://api.github.com") do |faraday|
     faraday.headers["Accept"] = "application/vnd.github.v3+json"
     faraday.adapter Faraday.default_adapter
    end
  end
end
