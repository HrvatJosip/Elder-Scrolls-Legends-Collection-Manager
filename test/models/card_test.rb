require 'test_helper'

class CardTest < ActiveSupport::TestCase
  def setup
    @creature_card = Card.new(name: 'Test card', text: 'This is an effect', magicka_cost: 1, attack: 100, health: 100,
                              quality: :legendary, race: :nord, type: :creature,set: 'Base', attributes: [:agility, :strength])
    @item_card = Card.new(name: 'test', text: 'this is a test', magicka_cost: 1, quality: :rare, type: :item, set: 'Base',
                          attributes: [:neutral])
  end

  test 'should be valid' do
    assert @creature_card.valid?
    assert @item_card.valid?
  end

  test 'name should be present' do
    @creature_card.name = '     '
    assert_not @creature_card.valid?
  end

  test 'cost should be present' do
    @creature_card.magicka_cost = nil
    assert_not @creature_card.valid?
  end

  test 'quality should be present' do
    @creature_card.quality = nil
    assert_not @creature_card.valid?
  end

  test 'type should be present' do
    @creature_card.type = nil
    assert_not @creature_card.valid?
  end

  test 'cost should be >= 0' do
    @creature_card.magicka_cost = -1
    assert_not @creature_card.valid?
  end

  test 'creature type should have attack and health' do
    @creature_card.type = :creature
    @creature_card.attack = nil
    @creature_card.health = nil
    assert_not @creature_card.valid?
  end

  test 'non-creature type should have black attack and health' do
    @item_card.attack = 1
    @item_card.health = 1
    assert_not @item_card.valid?
  end

  test 'creatures type must have a race' do
    @creature_card.type = :creature
    @creature_card.race = nil
    assert_not @creature_card.valid?
  end

  test 'non-creature type cannot have race' do
    @item_card.race = :nord
    assert_not @item_card.valid?
  end

  test 'card can only have 1 or 2 attributes' do
    @creature_card.attributes = []
    assert_not @creature_card.valid?
    @creature_card.attributes = [:strength, :willpower, :agility]
    assert_not @creature_card.valid?
  end

  test 'neutral must be a standalone attribute' do
    @creature_card.attributes = [:strength, :neutral]
    assert_not @creature_card.valid?
  end

  test 'cannot have duplicate attributes' do
    @creature_card.attributes = [:strength, :strength]
    assert_not @creature_card.valid?
  end

  test 'non-creature type must have text' do
    @item_card.text = nil
    assert_not @item_card.valid?
  end
end
