class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :user_id
      t.integer :grade_id

      t.timestamps
    end
    add_index :courses, :user_id
    add_index :courses, :grade_id
  end
end
