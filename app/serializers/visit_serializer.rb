class VisitSerializer < ActiveModel::Serializer
  attributes :id, :date, :status, :user_id, :checkin_at, :checkout_at

  link(:self) {visit_url(object.id)}
  link(:related) {user_visits_url(object.user_id)}

  def attributes(*args)
    data = super(*args)
    data[:date] = (I18n.l(object.date.to_time) unless object.date.blank?)
    data[:checkin_at] = (I18n.l(object.checkin_at) unless object.checkin_at.blank?)
    data[:checkout_at] = (I18n.l(object.checkout_at) unless object.checkout_at.blank?)
    data
  end
end
