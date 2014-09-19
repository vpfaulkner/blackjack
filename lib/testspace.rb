class Session
  attr_accessor :player_move
  attr_accessor :dealer_move

  def initialize
    @deck = Hash.new
    @player_cards = {}
    @player_count = 0
    @dealer_cards = {}
    @dealer_count = 0
    @player_move = "Hit"
    @dealer_move = "Hit"
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
    card_value = @deck[card.to_s]
    @player_cards[card] = card_value
  end

  def deal_dealer
    card = @deck.keys.sample
    card_value = @deck[card.to_s]
    @dealer_cards[card] = card_value
  end

  def get_player_count
    running_total = 0
    @player_count = @player_cards.each {|rank, value| running_total = running_total + value}
    @player_count = running_total
  end

  def get_player_move
    if @player_count > 21
      puts "Your hand is: #{@player_cards}. Your count is #{@player_count} so you busted!"
      @player_move = "Bust"
    else
      puts "Your hand is: #{@player_cards} and the dealer's is #{@dealer_cards}. Would you like to Hit or Stand (enter one)?"
      @player_move = gets.chop
    end
  end

  def get_dealer_count
    running_total = 0
    @dealer_count = @dealer_cards.each {|rank, value| running_total = running_total + value}
    @dealer_count = running_total
  end

  def get_dealer_move
    if @player_count > 21
      @dealer_move = "Stand"
    elsif @dealer_count < 17
      @dealer_move = "Hit"
    elsif @dealer_count < 21
      @dealer_move = "Stand"
    else
      @dealer_move = "Bust"
    end
  end

  def evaluate
    if "Bust" == @player_move
      return "Lost"
    elsif "Bust" == @dealer_move
      return "Won"
    elsif @player_count > @dealer_count
      return "Won"
    else
      return "Lost"
    end
  end

end

session = Session.new
while "Hit"  == session.player_move
  session.deal_player
  session.get_player_count
  session.get_player_move
end
session.deal_dealer
