class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(tut_params)
    if tutorial.save
      flash[:notice] = "Successfully created tutorial."
      redirect_to tutorial_path(tutorial.id)
    else
      flash[:error] = "Missing information, please try again"
      redirect_to new_admin_tutorial_path
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    Tutorial.find(params[:id]).destroy
    flash[:success] = "Tutorial and videos have been deleted"
    redirect_to admin_dashboard_path
  end

  private
  def tut_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end
end
