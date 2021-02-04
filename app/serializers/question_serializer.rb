class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :name, :formulary_id, :question_type

  has_one :answer do
    link(:self) {question_url(object.id)}
    link(:related) { question_answer_url(object.id)}
  end
end
