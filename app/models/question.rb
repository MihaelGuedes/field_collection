class Question < ApplicationRecord
  validates_uniqueness_of :name, scope: :formulary_id

  has_one :answer
end
