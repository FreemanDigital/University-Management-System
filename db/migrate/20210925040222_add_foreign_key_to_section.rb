class AddForeignKeyToSection < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :sections, :courses
  end
end
