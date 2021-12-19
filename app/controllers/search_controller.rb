class SearchController < ApplicationController

  def index
    if params[:query] == ''
      redirect_to '/', danger: "No results found"
      return
    end
    @teachers = Teacher.where("first_name LIKE ? OR last_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    @offices = Office.where("building_name LIKE ? OR floor_number LIKE ? OR room_number LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%").all
    @courses = Course.where("prefix LIKE ? OR number LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").all
    @sections = Section.where("year LIKE ? OR semester LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").all
    if @teachers.size > 0 or @offices.size > 0 or @courses.size > 0 or @sections.size > 0
      render :index
    else
      redirect_to '/', danger: "No results found"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_section
    #   @section = Section.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def search_params
      params.require(:teacher).permit(:first_name, :last_name, :nine_hundred, :email, :office_id)
      params.require(:section).permit(:year, :semester, :course_id)
      params.require(:office).permit(:building_name, :floor_number, :room_number)
      params.require(:course).permit(:prefix, :number, :description, :section_ids => [])
    end
end

