class Grade < ActiveRecord::Base
	belongs_to :course
	validates :grade,  :presence => true,
                      :length   => { :maximum => 100 }
end
