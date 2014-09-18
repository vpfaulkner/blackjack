class Rules

  def initialize
    @deck = Hash.new
    @player_cards = {}
    @dealer_cards = {}
  end

  def fill_deck
    ranks = {
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "10" => 10,
      "J" => 10,
      "Q" => 10,
      "K" => 10,
      "A" => 1
    }

    ranks.each do |rank, value|
      @deck["♣" + rank] = value
      @deck["♦" + rank] = value
      @deck["♥" + rank] = value
      @deck["♠" + rank] = value
    end
    puts @deck
  end

  def deal_player
    card = @deck.keys.sample
    card_value = @deck[card.to_s]
    @player_cards[card] = card_value
  end

  def deal_dealer
    card = @deck.keys.sample
    card_value = @deck[card.to_s]
    @dealer_cards[card] = card_value
  end

  def move

  end

  def end_game

  end

end

rules = Rules.new
rules.fill_deck
rules.deal_dealer
