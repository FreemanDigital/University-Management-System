class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.integer :year
      t.string :semester

      t.timestamps
    end
  end
end
