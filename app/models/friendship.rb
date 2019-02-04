class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :myself
  validates_presence_of :friend_id

  private

  def myself
    return unless user_id == friend_id
  end

end
