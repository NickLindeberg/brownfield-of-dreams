class Video < ApplicationRecord
  has_many :bookmarks
  has_many :users, through: :bookmarks
  belongs_to :tutorial

  validates :position, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  validates_presence_of :title, :description, :video_id
end
