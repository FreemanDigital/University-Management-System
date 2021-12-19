class SectionsController < ApplicationController
  before_action :set_section, only: %i[ show edit update destroy ]

  # GET /sections or /sections.json
  def index
    @sections = Section.all
  end

  # GET /sections/1 or /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    @section = Section.new
    @sections = Section.all
  end

  # GET /sections/1/edit
  def edit
    @sections = Section.all
  end

  # POST /sections or /sections.json
  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, success: "Section was successfully created." }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1 or /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to @section, success: "Section was successfully updated." }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1 or /sections/1.json
  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to sections_url, success: "Section was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    qry = params[:query].split(' ')
    if qry.size > 1
      @sections = Section.where("year LIKE ? AND semester LIKE ?", "%#{qry.first}%", "%#{qry.last}%").all
    else
      @sections = Section.where(
        "year LIKE ? 
        OR semester LIKE ?",
        "%#{params[:query]}%", "%#{params[:query]}%"
      ).all
    end
    if @sections.size > 0
      render :index
    else
      redirect_to sections_path, danger: "Section not found"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def section_params
      params.require(:section).permit(:year, :semester, :course_id)
    end
end
