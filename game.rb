require_relative 'board'
require_relative 'player'
require_relative 'computer'

class Game
  attr_reader :player

  def initialize(player, size = 4)
    @board = Board.new(size)
    @player = player
  end

  #play turn until its over
  def play
    puts
    puts "How good is your memory? Let's play a memory game."
    puts "Match the cards!"
    puts
    sleep(3)
    until game_over?
      board.render
      #get_pos from the player
      begin    
        make_guess(get_player_input)
      rescue => exception
        puts "Select a card that hasn't been flipped"
        retry
      end
      
    end
    puts "I guess your memory is pretty good :D"
  end

  def game_over?
    board.won?
  end

  def make_guess(pos)
    #reveal the pos
    revealed_value = board.reveal(pos)
    player.receive_revealed_card(pos, revealed_value)
    board.render

    #compare the guess
    compare_guess(pos)

    #keep board displayed for a bit
    sleep(1)
    board.render
  end

  def compare_guess(new_guess)
    prev_guess = player.previous_guess
    #compare if there is a previous_guess
    if prev_guess
      if match?(prev_guess, new_guess)
        player.receive_match(prev_guess, new_guess)
      else
        puts "Try again."
        #hide the match
        [prev_guess, new_guess].each { |pos| board.hide(pos) }
      end
      #reset guess
      player.previous_guess = nil
    #else set the previous_guess to guess
    else
      player.previous_guess = new_guess
    end
  end

  def match?(pos1, pos2)
    board[pos1] == board[pos2]
  end

  def get_player_input
    pos = nil
    until pos && valid_pos?(pos)
      pos = player.get_move
      if !valid_pos?(pos)
        puts "Please select a valid position on the board"
        pos = nil
      end
    end
    pos
  end

  def valid_pos?(pos)
    pos.count == 2 &&
    pos.is_a?(Array) &&
    pos.all?{ |num| num.between?(0, board.size - 1) }
  end

  private
  attr_reader :board
  attr_accessor :previous_guess

end

if $PROGRAM_NAME == __FILE__
  size = ARGV.empty? ? 4 : ARGV.shift.to_i
  Game.new(ComputerPlayer.new(size), size).play
end
