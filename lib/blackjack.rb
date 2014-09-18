class Blackjack
  def run
    game = Game.new
    while game.play_again?
      game.get_name
      game.get_bet
      game.play
      game.adjust_winnings
      game.play_again?
    end
    fail "You need to add some functionality here before you can use this."
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

  def initialize
    @player_name = nil
    @winnigs = nil
    @score = nil

    @wager = nil
    @result = nil
    
  end

  def get_name

  end

  def get_bet

  end

  def play

  end


  def adjust_winnings

  end

  def play_again?

  end

end
