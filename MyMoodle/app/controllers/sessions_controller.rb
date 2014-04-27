class SessionsController < ApplicationController
    def new
      @title = "SignIn"
      @users = User.all
      if (signed_in?)
        redirect_to current_user
      end
      if !@users.where(email: 'admin@mymoodle.ie').take
        Role.create(:name => "Admin")
        Role.create(:name => "Lecturer")
        Role.create(:name => "Student")
        User.create(:firstname => "Admin", :lastname => "GCD", :email => "admin@mymoodle.ie", :password => "admin", :role => Role.where(name: 'Admin').take)

        #Student creation
        User.create(:firstname => "Steeve", :lastname => "Chopart", :email => "steeve@mymoodle.ie", :password => "steeve", :role => Role.where(name: 'Student').take)
        User.create(:firstname => "Marc", :lastname => "Soufflet", :email => "marc@mymoodle.ie", :password => "marc", :role => Role.where(name: 'Student').take)
        User.create(:firstname => "Cyntia", :lastname => "Marquis", :email => "cyntia@mymoodle.ie", :password => "cyntia", :role => Role.where(name: 'Student').take)
        User.create(:firstname => "Lionel", :lastname => "Hamsoul", :email => "lionel@mymoodle.ie", :password => "lionel", :role => Role.where(name: 'Student').take)
        User.create(:firstname => "Raphael", :lastname => "Amar", :email => "raphael@mymoodle.ie", :password => "raphael", :role => Role.where(name: 'Student').take)
        User.create(:firstname => "Ryan", :lastname => "Legasal", :email => "ryan@mymoodle.ie", :password => "ryan", :role => Role.where(name: 'Student').take)
        User.create(:firstname => "Cedric", :lastname => "Merouani", :email => "cedric@mymoodle.ie", :password => "cedric", :role => Role.where(name: 'Student').take)
        User.create(:firstname => "Cyril", :lastname => "Morales", :email => "cyril@mymoodle.ie", :password => "cyril", :role => Role.where(name: 'Student').take)
        User.create(:firstname => "Guillaume", :lastname => "DeJambrun", :email => "guillaume@mymoodle.ie", :password => "guillaume", :role => Role.where(name: 'Student').take)

        #Lecturer creation
        User.create(:firstname => "Barry", :lastname => "Denby", :email => "barry@mymoodle.ie", :password => "barry", :role => Role.where(name: 'Lecturer').take)
        User.create(:firstname => "Tony", :lastname => "Mullins", :email => "tony@mymoodle.ie", :password => "tony", :role => Role.where(name: 'Lecturer').take)
        User.create(:firstname => "John", :lastname => "Delaney", :email => "john@mymoodle.ie", :password => "john", :role => Role.where(name: 'Lecturer').take)
        User.create(:firstname => "Jennifer", :lastname => "Trenor", :email => "jennifer@mymoodle.ie", :password => "jennifer", :role => Role.where(name: 'Lecturer').take)
        User.create(:firstname => "Deborah", :lastname => "Hopkin", :email => "deborah@mymoodle.ie", :password => "deborah", :role => Role.where(name: 'Lecturer').take)
        User.create(:firstname => "Justin", :lastname => "Keogan", :email => "justin@mymoodle.ie", :password => "justin", :role => Role.where(name: 'Lecturer').take)
        User.create(:firstname => "Rex", :lastname => "Tellor", :email => "rex@mymoodle.ie", :password => "rex", :role => Role.where(name: 'Lecturer').take)

        Course.create(:name => "Marketing")
        Course.create(:name => "Emerging Technologies")
        Course.create(:name => "Management")
        Course.create(:name => "Maths")
        Course.create(:name => "English")
        Course.create(:name => "Computer Graphics")
        Course.create(:name => "Web Framework")
        Course.create(:name => "Programing paradigm")
        Course.create(:name => "Managing big data")

        Semester.create(:start => Time.now, :end => 6.months.from_now )
      end
    end
  
    def create
        user = User.authenticate(params[:session][:email],
                                 params[:session][:password])
        if user.nil?
          flash.now[:error] = "Email/Password wrong."
          render 'new'
         else
          sign_in user
          redirect_to user  
        end
    end
  
  def destroy
     sign_out
     redirect_to root_path
   end
end

