class AddFormularyToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :formulary, null: false, foreign_key: true
  end
end
