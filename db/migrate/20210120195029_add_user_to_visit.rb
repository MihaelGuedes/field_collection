class AddUserToVisit < ActiveRecord::Migration[6.0]
  def change
    add_reference :visits, :user, null: false, foreign_key: true
  end
end
