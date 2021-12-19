class Section < ApplicationRecord
  belongs_to :course, optional: true

  def name
    "#{self.year} #{self.semester}"
  end

end
