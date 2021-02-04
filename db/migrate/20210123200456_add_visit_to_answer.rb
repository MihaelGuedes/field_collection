class AddVisitToAnswer < ActiveRecord::Migration[6.0]
  def change
    add_reference :answers, :visit, null: false, foreign_key: true
  end
end
