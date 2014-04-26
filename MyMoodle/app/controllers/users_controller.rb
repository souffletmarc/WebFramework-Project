class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  end
  
  # GET /users
  def liststudent
    @users = User.where(:role => Role.where(name: 'Student').take)
  end

  def listlecturer
    @users = User.where(:role => Role.where(name: 'Lecturer').take)
  end

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
  def newlecturer
    @user = User.new
  end

  def newstudent
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def createstudent
    @user = User.new(user_params)
      if @user.save
        redirect_to @user, notice: 'Student was successfully created.'
        render action: 'show', status: :created, location: @user 
      else
       render action: 'newstudent' 
      end
  end

  def createlecturer
     @user = User.new(user_params)
      if @user.save
        redirect_to @user, notice: 'Lecturer was successfully created.'
        render action: 'show', status: :created, location: @user 
      else
       render action: 'newlecturer' 
      end
  end

  # PATCH/PUT /users/1
  def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
        head :no_content 
      else
        render action: 'edit'
        ender json: @user.errors, status: :unprocessable_entity
      end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url
    head :no_content
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :firstname, :lastname, :email, :password, :salt)
    end
end
