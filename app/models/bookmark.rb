class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :tutorial
  belongs_to :video  
end
