class V1::CardsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_card, only: [:update, :destroy]
  before_action :set_list, only: [:index, :show]

  def index
    @cards = @list.cards.find_by(user_id: current_user)
  end

  def show
    @card = @list.cards.find(params[:id])
  end

  def create
    @card = Card.create(card_params)
    @card.user = current_user

    if @card.save
      render :show, status: :created    
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  def update
    if @card.update(card_params)
      render :show, status: :ok
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @card.destroy
  end

  private
  
    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.permit(:title, :description,:list_id)
    end

    def set_list
      @list = List.find(params[:list_id])      
    end
end
