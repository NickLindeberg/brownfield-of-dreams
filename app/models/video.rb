class Video < ApplicationRecord
  has_many :bookmarks
  has_many :users, through: :bookmarks
  belongs_to :tutorial

  validates :position, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
end
