require 'pry'

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
  end
end

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
    @deck.delete(card)
    @player_cards[card] = card_value
  end

  def deal_dealer
    card = @deck.keys.sample
    card_value = @deck[card.to_s]
    @deck.delete(card)
    @dealer_cards[card] = card_value
  end

  def get_player_count
    running_total = 0
    @player_count = @player_cards.each {|rank, value| running_total = running_total + value}
    @player_count = running_total
  end

  def get_player_move
    if @player_count > 21
      print "\n---------------------------------------------------\n\nYour hand is: #{@player_cards}. Your count is #{@player_count}\n\n"
      @player_move = "Bust"
    else
      print "\n---------------------------------------------------\n\nYour hand is: #{@player_cards} and the dealer's is #{@dealer_cards}. Would you like to Hit or Stand (enter one)?\n\nChoice: "
      @player_move = gets.chop
    end
  end

  def get_dealer_count
    running_total = 0
    @dealer_count = @dealer_cards.each {|rank, value| running_total = running_total + value}
    @dealer_count = running_total
  end

  def get_dealer_move
    if @dealer_count > 21
      @dealer_move = "Bust"
    elsif @dealer_cards.has_value?(1)
      if @dealer_count > 16
        @dealer_move = "Stand"
      elsif @dealer_count > 11
        @dealer_move = "Hit"
      elsif @dealer_count > 6
        ace = @dealer_cards.key(1)
        @dealer_cards[ace] = 11
        @dealer_count = @dealer_count + 10
        @dealer_move = "Stand"
      else # 6 or less
        @dealer_move = "Hit"
      end
    elsif @dealer_count < 17
      @dealer_move = "Hit"
    else #@dealer_count <= 21
      @dealer_move = "Stand"
    end
  end

  def evaluate
    if "Bust" == @player_move
      puts "---------------------------------------------------\n\nYou busted!\n\nYour hand: #{@player_cards} (#{@player_count})\nDealer's hand: #{@dealer_cards} (#{@dealer_count})\n\n"
      return "Lost"
    elsif "Bust" == @dealer_move
      puts "---------------------------------------------------\n\nYou won!\n\nYour hand: #{@player_cards} (#{@player_count})\nDealer's hand: #{@dealer_cards} (#{@dealer_count})\n\n"
      return "Won"
    # Add Ace Logic Here
    elsif @player_count > @dealer_count
      puts "---------------------------------------------------\n\nYou won!\n\nYour hand: #{@player_cards} (#{@player_count})\nDealer's hand: #{@dealer_cards} (#{@dealer_count})\n\n"
      return "Won"
    else
      puts "You lost.\n\nYour hand: #{@player_cards} (#{@player_count})\nDealer's hand: #{@dealer_cards} (#{@dealer_count})\n"
      return "Lost"
    end
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
    print "---------------------------------------------------\n\nWhat is your name?\n\nName: "
    @player_name = gets.chomp
    @score[@player_name] = 0
  end

  def give_stats
    puts "---------------------------------------------------\n\n  Name: #{@player_name}\n  Winnings: $#{@winnings}\n  Score: #{@score}\n\n"
  end

  def get_wager
    print "---------------------------------------------------\n\nHow much would you like to wager?\n\nWager: $"
    @wager = gets.chomp.to_i
    until @wager <= @winnings
      print "\nYou cannot wager more than your winnings which is #{@winnings}. Please submit another wager\n\nWager: $"
      @wager = gets.chomp.to_i
    end
  end

  def play
      session = Session.new
      session.fill_deck
      session.deal_player
      session.deal_dealer
      while "Hit"  == session.player_move
        session.deal_player
        session.get_player_count
        session.get_player_move
      end
      #session.deal_dealer
      while "Hit" == session.dealer_move
        session.deal_dealer
        session.get_dealer_count
        session.get_dealer_move
      end
      @result = session.evaluate
  end

  def adjust_winnings
    if @result == "Won"
      @winnings += @wager
      @score[@player_name] += 1
    else
      @winnings -= @wager
      @score["Dealer"] += 1
    end
  end

  def play_again?
    if 0 >= @winnings
      print "---------------------------------------------------\n\nSorry--you are out of money! Game over.\n\n"
      @game_status = "Over"
    else
      print "---------------------------------------------------\n\nThat was fun. Press Y to play again and N to exit.\n\nChoice: "
      status = gets.chomp
      @game_status = "Over" if "N" == status
    end
  end

end

go = Blackjack.new
go.run
