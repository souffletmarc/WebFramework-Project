class Course < ActiveRecord::Base
	has_many :user
	validates :name,  :presence => true,
                      :length   => { :maximum => 50 }
end
