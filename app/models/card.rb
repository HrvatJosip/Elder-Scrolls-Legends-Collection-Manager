class Card < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :magicka_cost, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :quality, presence: true
  validates :type, presence: true
  validate :creature_type_require_attack_and_health, :non_creature_type_cannot_have_attack_or_health,
           :can_only_have_one_or_two_attributes, :neutral_must_be_only_attribute,
           :cannot_have_duplicate_attributes, :creature_type_must_have_race,
           :non_creature_type_cannot_have_race, :non_creature_type_must_have_text

  as_enum :type, [:creature, :action, :support, :item], map: :string
  as_enum :quality, [:common, :rare, :epic, :legendary], map: :string
  as_enum :attributes, [:strength, :willpower, :endurance, :agility, :intelligence, :neutral],
          accessor: :join_table

  def creature_type_require_attack_and_health
    if type == :creature
      if health.blank?
        errors.add(:health, message: "creature health can't be blank")
      end
      if attack.blank?
        errors.add(:attack, message: "creature attack can't be blank")
      end
    end
  end

  def non_creature_type_cannot_have_attack_or_health
    if type != :creature
      if !health.blank?
        errors.add(:health, message: "non-creature cards can't have health")
      end
      if !attack.blank?
        errors.add(:attack, message: "non-creature cards can't have attack")
      end
    end
  end

  def can_only_have_one_or_two_attributes
    if attributes.count <= 0 || attributes.count > 2
      errors.add(:attributes, message: "can only have 1 or 2 attributes")
    end
  end

  def neutral_must_be_only_attribute
    if attributes.include?(:neutral)
      if attributes.count != 1
        errors.add(:attributes, message: "neutral can't have any more attributes")
      end
    end
  end

  def cannot_have_duplicate_attributes
    if attributes.count == 2
      attr_array = attributes.to_a
      if attr_array[0] == attr_array[1]
        errors.add(:attributes, message: "can't have duplicate attributes")
      end
    end
  end

  def creature_type_must_have_race
    if type == :creature
      if race.blank?
        errors.add(:race, message: "creatures must have a race")
      end
    end
  end

  def non_creature_type_cannot_have_race
    if type != :creature
      if !race.blank?
        errors.add(:race, message: "non creatures cannot have a race")
      end
    end
  end

  def non_creature_type_must_have_text
    if type != :creature
      if text.blank?
        errors.add(:text, message: "non creatures must have text")
      end
    end
  end
end
