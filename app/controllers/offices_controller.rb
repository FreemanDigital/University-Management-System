class OfficesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_office, only: %i[ show edit update destroy ]

  # GET /offices or /offices.json
  def index
    @offices = Office.all
  end

  # GET /offices/1 or /offices/1.json
  def show
  end

  # GET /offices/new
  def new
    @office = Office.new
    @offices = Office.all
  end

  # GET /offices/1/edit
  def edit
    @offices = Office.all
  end

  # POST /offices or /offices.json
  def create
    @office = Office.new(office_params)

    respond_to do |format|
      if @office.save
        format.html { redirect_to @office, success: "Office was successfully created." }
        format.json { render :show, status: :created, location: @office }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offices/1 or /offices/1.json
  def update
    respond_to do |format|
      if @office.update(office_params)
        format.html { redirect_to @office, success: "Office was successfully updated." }
        format.json { render :show, status: :ok, location: @office }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offices/1 or /offices/1.json
  def destroy
    @office.destroy
    respond_to do |format|
      format.html { redirect_to offices_url, success: "Office was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    # qry = params[:query].split(' ')
    # if qry.size > 1
    #   @offices = Office.where("first_name LIKE ? AND last_name LIKE ?", "%#{qry.first}%", "%#{qry.last}%").all
    # else
      @offices = Office.where(
        "building_name LIKE ? 
        OR floor_number LIKE ?
        OR room_number LIKE ?",
        "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"
      ).all
    # end
    if @offices.size > 0
      render :index
    else
      redirect_to offices_path, danger: "Office not found"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_office
      @office = Office.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def office_params
      params.require(:office).permit(:building_name, :floor_number, :room_number)
    end
end
