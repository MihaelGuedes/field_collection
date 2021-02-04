require 'rails_helper'

RSpec.describe Formulary, type: :model do
  it 'valid name' do
    formulary = Formulary.new(name: 'first formulary')
    expect(formulary).to be_valid
  end

  it 'not valid name' do
    formulary = Formulary.new(name: 'first formulary')
    formulary.save
    formulary2 = Formulary.new(name: 'first formulary')
    formulary2.valid?
    expect(formulary2.errors[:name]).to include('já está em uso')
  end
end
