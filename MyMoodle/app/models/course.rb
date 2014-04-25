class Course < ActiveRecord::Base
	has_many :user
	has_many :grade
	validates :name,  :presence => true,
                      :length   => { :maximum => 50 }
end
