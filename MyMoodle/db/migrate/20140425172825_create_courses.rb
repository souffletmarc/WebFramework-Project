class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
 
    create_table :courses_users, id: false do |t|
      t.belongs_to :course
      t.belongs_to :user
    end
    add_index :courses, :user_id
    
  end
end
