class Formulary < ApplicationRecord
  validates_uniqueness_of :name

  has_many :questions
end
