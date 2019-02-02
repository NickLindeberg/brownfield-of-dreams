class Video < ApplicationRecord
  has_many :bookmarks
  has_many :users, through: :bookmarks
  belongs_to :tutorial
end
