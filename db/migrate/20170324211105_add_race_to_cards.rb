class AddRaceToCards < ActiveRecord::Migration[5.0]
  def change
    change_table :cards do |t|
      t.column :race, :string
    end
  end
end
