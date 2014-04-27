class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_filter :is_student, :only => [:students_courses, :show, :add_user, :del_user]
  before_filter :is_lecturer, :only => [:show]
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
      else
        render action: 'new'
      end
   
  end

  # PATCH/PUT /courses/1
  def update
      if @course.update(course_params)
        redirect_to @course, notice: 'Course was successfully updated.'
      else
        render action: 'edit'
      end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to admins_modules_path
  end

  def add_user
   @course = Course.find(params[:id])

   if current_user.role_id == Role.where(name: 'Admin').take.id
      user_lecturer = User.find_by_id(params[:lecturer_id])
      if user_lecturer != nil && !user_lecturer.courses.include?(@course) && user_lecturer.courses.size < 3
        @course.users << user_lecturer 
      end
      redirect_to admins_modules_path
   else
      if !current_user.courses.include?(@course) && current_user.courses.size < 5
        @course.users << current_user
      end
      redirect_to students_modules_path
    end
  end

  def add_mark
    user_student = User.find_by_id(params[:user_id])
    if user_student != nil && !(user_student.grades.where(course_id: params[:course_id]).any?)
      user_student.grades << Grade.create(grade: params[:mark], user_id: user_student.id, course_id: params[:course_id])
    end
    redirect_to course_path(params[:course_id])
  end
  
  def update_mark
    @mark = Grade.where(user_id: params[:user_id], course_id: params[:course_id]).take
    @mark.grade = params[:mark].to_i
    @mark.save
    redirect_to course_path(params[:course_id])
  end
  
  def del_user
   @course = Course.find(params[:id])
    if current_user.courses.include?(@course)
       @course.users.destroy(current_user)
    end
    redirect_to students_modules_path
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
