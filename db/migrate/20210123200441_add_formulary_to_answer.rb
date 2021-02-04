class AddFormularyToAnswer < ActiveRecord::Migration[6.0]
  def change
    add_reference :answers, :formulary, null: false, foreign_key: true
  end
end
