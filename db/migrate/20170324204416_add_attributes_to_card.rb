class AddAttributesToCard < ActiveRecord::Migration[5.0]
  def change
    create_join_table :cards, :attributes
  end
end
