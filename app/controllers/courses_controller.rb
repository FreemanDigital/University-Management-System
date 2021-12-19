class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
    @courses = Course.all
  end

  # GET /courses/1/edit
  def edit
    @courses = Course.all
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, success: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, success: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, success: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    # qry = params[:query].split(' ')
    # if qry.size > 1
    #   @courses = Course.where("first_name LIKE ? AND last_name LIKE ?", "%#{qry.first}%", "%#{qry.last}%").all
    # else
      @courses = Course.where(
        "prefix LIKE ? 
        OR number LIKE ?",
        "%#{params[:query]}%", "%#{params[:query]}%"
      ).all
    # end
    if @courses.size > 0
      render :index
    else
      redirect_to courses_path, danger: "Course not found"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:prefix, :number, :description, :section_ids => [])
    end
end
