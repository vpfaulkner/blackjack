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


class Deck

  deck = {}

end

class Player

  def deal

  end

  hand = []

end

class Dealer

  hand = []

  def deal

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
      # Fill in
      # Define @result here
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
