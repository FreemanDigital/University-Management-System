class TeachersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher, only: %i[ show edit update destroy ]

  # GET /teachers or /teachers.json
  def index
    @teachers = Teacher.all
  end

  # GET /teachers/1 or /teachers/1.json
  def show
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
    @teachers = Teacher.all
  end

  # GET /teachers/1/edit
  def edit
    @teachers = Teacher.all
  end

  # POST /teachers or /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, success: "Teacher was successfully created." }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1 or /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to @teacher, success: "Teacher was successfully updated." }
        format.json { render :show, status: :ok, location: @teacher }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1 or /teachers/1.json
  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url, success: "Teacher was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    qry = params[:query].split(' ')
    if qry.size > 1
      @teachers = Teacher.where("first_name LIKE ? AND last_name LIKE ?", "%#{qry.first}%", "%#{qry.last}%").all
    else
      @teachers = Teacher.where("first_name LIKE ? OR last_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").all
    end
    if @teachers.size > 0
      render :index
    else
      redirect_to teachers_path, danger: "Teacher not found"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def teacher_params
      params.require(:teacher).permit(:first_name, :last_name, :nine_hundred, :email, :office_id)
    end
end
