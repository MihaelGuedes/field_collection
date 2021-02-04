class Answer < ApplicationRecord
  validates_presence_of :question_id
  validates_presence_of :formulary_id
end
