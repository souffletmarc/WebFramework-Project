class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  
  def index
    @courses = Course.all
  end

  def students_courses
    @courses = Course.all
  end

  def lecturers_courses
    @courses = Course.all
  end

  def admins_courses
    @courses = Course.all
  end

  # GET /courses/1
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
      if @course.save
        redirect_to @course, notice: 'Course was successfully created.'
        render action: 'show', status: :created, location: @course
      else
        render action: 'new'
        render json: @course.errors, status: :unprocessable_entity
      end
   
  end

  # PATCH/PUT /courses/1
  def update
      if @course.update(course_params)
        redirect_to @course, notice: 'Course was successfully updated.'
        head :no_content
      else
        render action: 'edit'
        render json: @course.errors, status: :unprocessable_entity
      end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url
    head :no_content
    
  end

  def add_user
   @course = Course.find(params[:id])
   @course.users << current_user
    respond_to do |format|
      format.html { redirect_to students_modules_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name)
    end
end
