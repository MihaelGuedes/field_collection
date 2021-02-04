require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'valid name' do
    question = Question.new(name: 'first question')
    expect(question).to be_valid
  end

  it 'valid name in another formulary' do
    formulary = Formulary.new(name: 'first formulary')
    formulary.save
    formulary2 = Formulary.new(name: 'second formulary')
    formulary2.save
    question = Question.new(name: 'first question', formulary_id: 1)
    question.save
    question2 = Question.new(name: 'first question', formulary_id: 2)
    expect(question2).to be_valid
  end

  it 'invalid name on the same form' do
    formulary = Formulary.new(name: 'first formulary')
    formulary.save
    question = Question.new(name: 'first question', formulary_id: 1)
    question.save
    question2 = Question.new(name: 'first question', formulary_id: 1)
    question2.valid?
    expect(question2.errors[:name]).to include('já está em uso')
  end
end
