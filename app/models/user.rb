class User < ApplicationRecord
  has_many :bookmarks
  has_many :tutorials, through: :bookmarks
  has_many :videos, through: :bookmarks  

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password
end
