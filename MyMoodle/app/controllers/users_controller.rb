class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :is_student, :only => [:show]
  before_filter :is_lecturer, :only => [:show, :search]
  def index
  end
  
  # GET /users
 
  def lecturers_index
    @users = User.where(role: Role.where(name: 'Lecturer').take)
  end

  def students_index
    @users = User.where(role: Role.where(name: 'Student').take)
  end
  # GET /users/1
  def show
  end

  # GET /users/new
  def new_lecturer
    @user = User.new
  end

  def new_student
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # GET /search
  def search
    if User.where("role_id = ? AND (id = ? OR lower(firstname) = ? OR lower(lastname) = ?)", Role.where(name: params[:search_who]).take, params[:search_entry].downcase, params[:search_entry].downcase, params[:search_entry].downcase).any?
      @users = User.where("role_id = ? AND (id = ? OR lower(firstname) = ? OR lower(lastname) = ?)", Role.where(name: params[:search_who]).take, params[:search_entry].downcase, params[:search_entry].downcase, params[:search_entry].downcase)
    else
      @users = User.where(role: Role.where(name: params[:search_who]).take)
    end
    if params[:search_who] == "Lecturer"
      render action: 'lecturers_index'
    else
      render action: 'students_index'
    end
  end
  
  def create
    if params[:role] ==  Role.where(name: 'Student').take.id
      create_student
    else
      create_lecturer
    end
  end

  # POST /users
  def create_student
    @user = User.new(user_params)
      if @user.save
        redirect_to @user, notice: 'Student was successfully created.'
      else
       render action: 'new_student' 
      end
  end

  def create_lecturer
     @user = User.new(user_params)
      if @user.save
        redirect_to @user, notice: 'Lecturer was successfully created.'
      else
       render action: 'new_lecturer' 
      end
  end

  # PATCH/PUT /users/1
  def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render action: 'edit'
      end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    if params[:role_id] ==  Role.where(name: 'Student').take.id
    redirect_to students_url
    else
    redirect_to lecturers_url
    end
  end

  def courses_without_lecturer(user_lecturer)
    @courses = Course.all
    tab = Array.new
    @courses.each do |mod|
      if mod.users.where(role_id: Role.where(name: "Lecturer").take.id).count == 0
        tab.push mod
      end
    end
    return tab
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :firstname, :lastname, :email, :password, :salt, :role_id)
    end
end
