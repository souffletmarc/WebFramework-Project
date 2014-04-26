class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
    if User.where("role_id = ? AND (id = ? OR firstname = ? OR lastname = ?)", Role.where(name: params[:search_who]).take, params[:search_entry], params[:search_entry], params[:search_entry]).any?
      @users = User.where("role_id = ? AND (id = ? OR firstname = ? OR lastname = ?)", Role.where(name: params[:search_who]).take, params[:search_entry], params[:search_entry], params[:search_entry])
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
        render action: 'show', status: :created, location: @user 
      else
       render action: 'new_student' 
      end
  end

  def create_lecturer
     @user = User.new(user_params)
      if @user.save
        redirect_to @user, notice: 'Lecturer was successfully created.'
        render action: 'show', status: :created, location: @user 
      else
       render action: 'new_lecturer' 
      end
  end

  # PATCH/PUT /users/1
  def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
        head :no_content 
      else
        render action: 'edit'
        render json: @user.errors, status: :unprocessable_entity
      end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    if params[:role] ==  Role.where(name: 'Student').take.id
    redirect_to students_url
    else
    redirect_to lecturers_url
    end
    head :no_content
    
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
