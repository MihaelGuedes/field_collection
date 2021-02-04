require 'rails_helper'

RSpec.describe Visit, type: :model do
  context 'validate date' do
    it 'valid presence' do
      visit = Visit.new(date: '30/12/2021', user_id: 1)
      expect(visit).to be_valid
    end

    it 'not valid without date' do
      visit = Visit.new(date: nil, user_id: 1)
      visit.valid?
      expect(visit.errors[:date]).to include('não pode ficar em branco')
    end
  end

  context 'status change' do
    it 'to realizing' do
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      visit = Visit.create(date: Date.today, user_id: '1')
      visit.checkin_at = Time.current
      visit.save
      expect(visit.status).to eq('realizing')
    end

    it 'to finished' do
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      visit = Visit.create(date: Date.today, user_id: '1')
      visit.checkin_at = Time.now
      visit.checkout_at = Time.current
      visit.save
      expect(visit.status).to eq('finished')
    end
  end
end
