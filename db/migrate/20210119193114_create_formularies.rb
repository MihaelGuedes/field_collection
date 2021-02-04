class CreateFormularies < ActiveRecord::Migration[6.0]
  def change
    create_table :formularies do |t|
      t.string :name

      t.timestamps
    end
  end
end
