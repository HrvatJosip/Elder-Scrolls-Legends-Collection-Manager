class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to @card
    else
      render :new
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])

    if @card.update(card_params)
      redirect_to @card
    else
      render :edit
    end
  end

  private

  def card_params
    params.require(:card).permit(:name, :text, :magicka_cost, :attack, :health, :quality, :race, :type, attributes:[])
  end

  def find_card
    @card = Card.find(params[:id])
  end
end
