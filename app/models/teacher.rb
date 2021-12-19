class Teacher < ApplicationRecord
  belongs_to :office, optional: true

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
