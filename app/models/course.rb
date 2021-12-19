class Course < ApplicationRecord
  has_many :sections, dependent: :nullify

  def name
    "#{self.prefix}#{self.number}"
  end
end
