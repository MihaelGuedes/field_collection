class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :formulary_id, :question_id, :visit_id, :answered_at
end
