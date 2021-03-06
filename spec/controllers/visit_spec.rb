require 'rails_helper'

describe VisitsController, type: :controller do

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

  context 'GET checkin_at' do
    it 'valid' do
      request.accept = 'application/vnd.api+json'
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      visit = Visit.new(date: Date.today, user_id: 1)
      visit.save
      if Time.current >= visit.date.to_time
        get :checkin_at, params: { id: visit.id }
        expect(response).to have_http_status(200)
        response_body = JSON.parse(response.body)
        expect(response_body.fetch('data').fetch('id')).to eq(visit.id.to_s)
      end
    end

    it 'invalid because the visit cannot be started yet' do
      request.accept = 'application/vnd.api+json'
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      visit = Visit.new(date: Date.tomorrow, user_id: 1)
      visit.save
      if Time.current >= visit.date.to_time
        visit.checkin_at = Time.current
        visit.save
      end
      get :checkin_at, params: { id: visit.id }
      expect(response).to have_http_status(:forbidden)
    end

    it 'invalid because checkin_at is already filled' do
      request.accept = 'application/vnd.api+json'
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      visit = Visit.new(date: Date.today, user_id: 1)
      visit.checkin_at = Time.current
      visit.save
      get :checkin_at, params: { id: visit.id }
      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'GET checkout_at' do
    it 'validate' do
      request.accept = 'application/vnd.api+json'
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      visit = Visit.new(date: Date.today, user_id: 1)
      if Time.current >= visit.date.to_time
        visit.checkin_at = Time.current
        visit.save
      end
      get :checkout_at, params: { id: visit.id }
      expect(response).to have_http_status(200)
      response_body = JSON.parse(response.body)
      expect(response_body.fetch('data').fetch('id')).to eq(visit.id.to_s)
    end

    it 'invalid because visit dont started' do
      request.accept = 'application/vnd.api+json'
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      visit = Visit.new(date: Date.tomorrow, user_id: 1)
      visit.save
      if Time.current >= visit.date.to_time
        visit.checkin_at = Time.current
        visit.save
      end
      get :checkout_at, params: { id: visit.id }
      expect(response).to have_http_status(:forbidden)
    end

    it 'invalid because checkin_at are nil' do
      request.accept = 'application/vnd.api+json'
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      visit = Visit.new(date: Date.today, user_id: 1)
      visit.save
      get :checkout_at, params: { id: visit.id }
      expect(response).to have_http_status(:forbidden)
    end

    it 'invalid because checkout_at is already filled' do
      request.accept = 'application/vnd.api+json'
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      visit = Visit.new(date: Date.today, user_id: 1)
      visit.checkin_at = Time.current
      visit.checkout_at = Time.current
      visit.save
      get :checkout_at, params: { id: visit.id }
      expect(response).to have_http_status(:forbidden)
    end
  end
end
