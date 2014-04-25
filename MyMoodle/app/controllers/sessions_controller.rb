class SessionsController < ApplicationController
    def new
      @title = "SignIn"
      @users = User.all
      if !@users.where(email: 'admin@gcd.ie').take
        Role.create(:name => "Admin")
        Role.create(:name => "Lecturer")
        Role.create(:name => "Student")
        User.create(:firstname => "Admin", :lastname => "GCD", :email => "admin@gcd.ie", :password => "admin", :role => Role.where(name: 'Admin').take)
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

