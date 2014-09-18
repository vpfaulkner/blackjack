class Blackjack
  def run
    game = Game.new
    game.get_name
    while nil == game.game_status
      game.give_stats
      game.get_wager
      game.play
      game.adjust_winnings
      game.play_again?
    end
    # fail "You need to add some functionality here before you can use this."
  end
end

class Session

  def initialize
    @deck = Hash.new
    @player_cards = {}
    @dealer_cards = {}
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
    card_value = @deck[card.to_s]
    @player_cards[card] = card_value
  end

  def deal_dealer
    card = @deck.keys.sample
    card_value = @deck[card.to_s]
    @dealer_cards[card] = card_value
  end

  def move
    puts "Your hand is: #{@player_cards} and the dealer's is #{@dealer_cards}. Would you like to Hit or Stand (enter one)?"
    @move = gets.chop
  end

  def end_game
    # if # Bust
    #   # Code here
    # elsif # @move == "Hit"
    #   # Restart cyle
    # else #Stand
    #   if # Fill with evaluation criteria. end_game method should return "Won" or "Lost"
    #     return "Lost"
    #   else
    #     return "Won"
    #   end
    # end
  end

end

class Game
  attr_accessor :game_status

  def initialize
    @game_status = nil
    @player_name = nil
    @winnings = 100
    @score = {
      "Dealer" => 0
    }
    @wager = nil
    @result = nil

  end

  def get_name
    print "Please give me your name: "
    @player_name = gets.chomp
    @score[@player_name] = 0
  end

  def give_stats
    puts "Here are your session statistics: \n\n  Name: #{@player_name}\n  Winnings: #{@winnings}\n  Score: #{@score}\n\n"
  end

  def get_wager
    print "How much would you like to wager? "
    @wager = gets.chomp.to_i
    until @wager <= @winnings
      print "You cannot wager more than your winnings which is #{@winnings}. Please submit another wager: "
      @wager = gets.chomp.to_i
    end
  end

  def play
      session = Session.new
      session.fill_deck
      session.deal_player
      session.deal_dealer
      #while nil == @result UNCOMMENT THIS LATER
        session.deal_player
        session.deal_dealer
        session.move
        @results = session.end_game
      #end
  end

  def adjust_winnings
    if @result == "Won"
      puts "You won!"
      @winnings += @wager
      @score[@player_name] += 1
    else
      puts "You lost."
      @winnings -= @wager
      @score["Dealer"] += 1
    end
  end

  def play_again?
    if 0 >= @winnings
      puts "Sorry--you are out of money! Game over."
      @game_status = "Over"
    else
      puts "That was fun. Press Y to play again and N to exit."
      status = gets.chomp
      @game_status = "Over" if "N" == status
    end
  end

end

go = Blackjack.new
go.run
