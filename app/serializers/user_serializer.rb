class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :password, :email, :cpf

  has_many :visits do
    link(:self) {user_url(object.id)}
    link(:related) {user_visits_url(object.id)}
  end
end
