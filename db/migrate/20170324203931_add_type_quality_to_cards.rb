class AddTypeQualityToCards < ActiveRecord::Migration[5.0]
  def change
    change_table :cards do |t|
      t.column :quality_cd, :string
      t.column :type_cd, :string
    end
  end
end
