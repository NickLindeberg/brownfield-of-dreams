class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if current_user == nil || !current_user.admin?
      if tutorial.videos.empty?
        flash[:error] = "That tutorial does not currently have videos"
        redirect_to root_path
      end
    else current_user.admin?
    end
    redirect_to root_path unless tutorial.classroom == false || current_user
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
