class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :grade
      t.integer :user_id
      t.integer :course_id
      t.timestamps
    end
    add_index :grades, :user_id
    add_index :grades, :course_id
  end
end
