module SessionsHelper
  def sign_in(user)
     cookies.permanent.signed[:remember_token] = [user.id, user.salt]
     self.current_user = user
   end
   
   def signed_in?
   !current_user.nil?
   end
   
   def sign_out
   cookies.delete(:remember_token)
   self.current_user = nil
   end
   
   def current_user?(user)
     @current_user == user
   end
   
   def current_user=(user)
    @current_user = user
  end
   
   def current_user
    @current_user ||= user_from_remember_token
  end

  def is_student 
    return false unless current_user.role_id == Role.where(name: 'Student').take.id
  end

  def is_lecturer 
    return false unless current_user.role_id == Role.where(name: 'Lecturer').take.id
  end

  def is_admin
    return false unless current_user.role_id == Role.where(name: 'Admin').take.id
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
    
    def authenticate
      deny_access unless signed_in?
    end

    def deny_access
    store_location
    redirect_to signin_path, :notice => "Thank to Singin to enter in this page."
    end
 
    def store_location
      session[:return_to] = request.fullpath
    end   

    
    
  end
   

