class SemestersController < ApplicationController
  before_action :set_semester, only: [:show, :edit, :update, :destroy]

  # GET /semesters
  def index
    @semesters = Semester.all
  end

  # GET /semesters/1
  def show
  end

  # GET /semesters/new
  def new
    @semester = Semester.new
  end

  # GET /semesters/1/edit
  def edit
  end

  # POST /semesters
  def create
    @semester = Semester.new(semester_params)
      if @semester.save
      redirect_to @semester, notice: 'Semester was successfully created.'
      render action: 'show', status: :created, location: @semester 
      else
        render action: 'new' 
        
      end
  end

  # PATCH/PUT /semesters/1
  def update
      if @semester.update(semester_params)
        redirect_to @semester, notice: 'Semester was successfully updated.'
      else
        render action: 'edit'
      end
  end

  # DELETE /semesters/1
  def destroy
    @semester.destroy
    redirect_to semesters_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_semester
      @semester = Semester.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def semester_params
      params.require(:semester).permit(:date, :date)
    end
end
