class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_filter :is_student, :only => [:show]
  before_filter :is_admin, :only => []

  # GET /grades
  # GET /grades.json
  def index
    @grades = Grade.all
  end

  # GET /grades/1
  def show
  end

  # GET /grades/new
  def new
    @grade = Grade.new
  end

  # GET /grades/1/edit
  def edit
  end

  # POST /grades
  def create
    @grade = Grade.new(grade_params)
      if @grade.save
        redirect_to @grade, notice: 'Grade was successfully created.'
        render action: 'show', status: :created, location: @grade
      else
        render action: 'new'
      end
    
  end

  # PATCH/PUT /grades/1
  def update
      if @grade.update(grade_params)
        redirect_to @grade, notice: 'Grade was successfully updated.'
      else
        render action: 'edit'
      end
  end

  # DELETE /grades/1
  def destroy
    @grade.destroy
    redirect_to grades_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:grade)
    end
end
