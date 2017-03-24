class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.text :text
      t.integer :magicka_cost
      t.integer :attack
      t.integer :health
      t.string :set

      t.timestamps
    end
  end
end
