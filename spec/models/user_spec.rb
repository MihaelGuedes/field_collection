require 'rails_helper'

RSpec.describe User, type: :model do

  it 'valid all presences' do
    user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
    expect(user).to be_valid
  end

  context 'validates emails' do
    it 'not valid without email' do
      user = User.new(email: nil, password: '123456', cpf: '70904357414')
      user.valid?
      expect(user.errors[:email]).to include('não pode ficar em branco')
    end

    it 'validate unique email' do
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      user2 = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user2.valid?
      expect(user2.errors[:email]).to include('já está em uso')
    end
  end

  context 'validate password' do
    it 'valid password' do
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.valid?
      expect(user).to be_valid
    end
    
    it 'not valid password length' do
      user = User.new(email: 'email@example.com', password: '12345', cpf: '70904357414')
      user.valid?
      expect(user.errors[:password]).to include('é muito curto (mínimo: 6 caracteres)')
    end
  end

  context 'validates CPF' do
    it 'validate unique cpf' do
      user = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user.save
      user2 = User.new(email: 'email@example.com', password: '123456', cpf: '70904357414')
      user2.valid?
      expect(user2.errors[:cpf]).to include('já está em uso')
    end

    it 'not valid CPF format' do
      user = User.new(email: 'email@example.com', password: '123456', cpf: '12345678910')
      user.valid?
      expect(user.errors[:cpf]).to include('não é um CPF válido')
    end

    it 'not valid without cpf' do
      user = User.new(email: 'email@example.com', password: '123456', cpf: nil)
      user.valid?
      expect(user.errors[:cpf]).to include('não pode ficar em branco')
    end
  end
end
