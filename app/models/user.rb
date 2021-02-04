class User < ApplicationRecord
  require 'cpf_cnpj'

  has_many :visits

  # Email
  validates_presence_of :email
  validates_uniqueness_of :email

  # Password
  validates_length_of :password, minimum: 6

  # CPF
  validates_cpf_format_of :cpf
  validates_presence_of :cpf
  validates_uniqueness_of :cpf
end
