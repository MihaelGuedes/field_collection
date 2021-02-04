require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'valid all presences' do
    answer = Answer.new(content: 'first answer', question_id: 1, formulary_id: 1)
    expect(answer).to be_valid
  end

  it 'not valid without question_id' do
    answer = Answer.new(content: 'first answer', question_id: nil, formulary_id: 1)
    answer.valid?
    expect(answer.errors[:question_id]).to include('não pode ficar em branco')
  end

  it 'not valid without formulary_id' do
    answer = Answer.new(content: 'first answer', question_id: 1, formulary_id: nil)
    answer.valid?
    expect(answer.errors[:formulary_id]).to include('não pode ficar em branco')
  end
end
