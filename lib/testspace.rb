class Session

  def initialize
  @deck = Hash.new
  @player_cards = {}
  @player_count = 0
  @dealer_cards = {}
  @dealer_count = 0
  @move = nil
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

  end

  def deal_player
    card = @deck.keys.sample
    puts card.inspect
    card_value = @deck[card.to_s]
    puts card_value.inspect
    @player_cards[card] = card_value
    puts @player_cards.inspect
  end

  def get_player_count
    running_total = 0
    @player_count = @player_cards.each {|rank, value| running_total = running_total + value}
    @player_count = running_total
    puts @player_count
  end

end

session = Session.new
session.fill_deck
session.deal_player
session.deal_player
session.get_player_count
