class Bookmark < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :tutorial, foreign_key: "tutorial_id"
  belongs_to :video, foreign_key: "video_id"
end
