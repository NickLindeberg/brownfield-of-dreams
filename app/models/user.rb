class User < ApplicationRecord
  has_many :bookmarks
  has_many :tutorials, through: :bookmarks
  has_many :videos, through: :bookmarks

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def uniq_tutorials
    bookmarks
      .joins(:tutorial)
      .select("DISTINCT tutorials.title AS tut_tile, tutorials.description AS tut_desc, tutorials.thumbnail AS tut_thumbnail")
  end

  def bookmarked_segments
    uniq_tutorials.joins(:video).select("videos.*").order("tutorials.title, videos.position")
  end
end
