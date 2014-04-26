class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password
      t.string :salt
      t.integer :role_id
      t.integer :course_id
      t.integer :grade_id

      t.timestamps
    end
    add_index :users, :role_id
    add_index :users, :course_id
    add_index :users, :grade_id
  end
end
