class Card < ApplicationRecord
  as_enum :type, [:creature, :action, :support, :item], map: :string
  as_enum :quality, [:common, :rare, :epic, :legendary], map: :string
  as_enum :attributes, [:strength, :willpower, :endurance, :agility, :intelligence, :neutral], accessor: :join_table
end
