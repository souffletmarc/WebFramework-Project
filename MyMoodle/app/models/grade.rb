class Grade < ActiveRecord::Base
	belongs_to :user
	validates :grade,  :presence => true,
                      :length   => { :maximum => 100 }
end
