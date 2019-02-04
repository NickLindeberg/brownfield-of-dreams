class User < ApplicationRecord
  has_many :bookmarks
  has_many :tutorials, through: :bookmarks
  has_many :videos, through: :bookmarks
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def uniq_tutorials
    bookmarks
      .joins(:tutorial)
      .select("DISTINCT tutorials.id AS tut_id, tutorials.title AS tut_title, tutorials.description AS tut_desc, tutorials.thumbnail AS tut_thumbnail, bookmarks.id AS bookmark_id")
  end

  def bookmarked_segments
    uniq_tutorials.joins(:video).select("videos.*").order("tutorials.title, videos.position")
  end
end
