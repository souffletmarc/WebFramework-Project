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

        #Lecturer creation
        User.create(:firstname => "Barry", :lastname => "Debny", :email => "barry@mymoodle.ie", :password => "barry", :role => Role.where(name: 'Lecturer').take)
        User.create(:firstname => "Tony", :lastname => "Mullins", :email => "tony@mymoodle.ie", :password => "tony", :role => Role.where(name: 'Lecturer').take)
        User.create(:firstname => "Denis", :lastname => "Lupiana", :email => "denis@mymoodle.ie", :password => "denis", :role => Role.where(name: 'Lecturer').take)

        

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

