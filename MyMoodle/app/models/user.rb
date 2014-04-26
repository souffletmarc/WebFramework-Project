class User < ActiveRecord::Base
    belongs_to :role
    has_and_belongs_to_many :courses
    has_many :grade

    before_save :encrypt_password
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :firstname,  :presence => true,
                      :length   => { :maximum => 50 }
    validates :lastname,  :presence => true,
                      :length   => { :maximum => 50 }
    validates :email, :presence => true,
                      :format   => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false } 
  def self.authenticate(email, submitted_password)
       user = find_by_email(email)
       return nil  if user.nil?
       return user if user.has_password?(submitted_password)
     end
 
     def has_password?(password_soumis)
      password == encrypt(password_soumis)
      end
  
      
    private
  
      def encrypt_password
        self.salt = make_salt if new_record?
        self.password = encrypt(password)
      end
  
      def encrypt(string)
        secure_hash("#{salt}--#{string}")
      end
  
      def make_salt
        secure_hash("#{Time.now.utc}--#{password}")
      end
  
      def secure_hash(string)
        Digest::SHA2.hexdigest(string)
      end
     
      def self.authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      return nil  if user.nil?
      return user if user.salt == cookie_salt
      end

end
