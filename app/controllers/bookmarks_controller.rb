class BookmarksController < ApplicationController
  def new
  end

  def create
    bookmark = Bookmark.new(bookmark_params)
    if current_user.bookmarks.find_by(video_id: bookmark.video_id)
      flash[:error] = "Already in your bookmarks"
    elsif bookmark.save
      flash[:success] = "Bookmark added to your dashboard!"
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def bookmark_params
    params.permit(:user_id, :tutorial_id, :video_id)
  end
end
