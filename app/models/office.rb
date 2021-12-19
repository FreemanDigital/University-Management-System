class Office < ApplicationRecord
  has_one :teacher, dependent: :nullify

  def name
    "#{self.building_name} #{self.room_number}"
  end
end
