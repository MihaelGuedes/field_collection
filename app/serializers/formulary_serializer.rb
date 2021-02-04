class FormularySerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :questions do
    link(:self) {formulary_url(object.id)}
    link(:related) { formulary_questions_url(object.id)}
  end
end
