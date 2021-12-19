class AddCourseIdToSection < ActiveRecord::Migration[6.1]
  def change
    add_column :sections, :course_id, :integer
    add_index :sections, :course_id
  end
end
