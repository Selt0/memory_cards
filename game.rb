require_relative 'board'

class Game

  def initialize(size = 4)
    @board = Board.new(size)
    @previous_guess = nil
  end

  #play turn until its over
  def play
    puts
    puts "How good is your memory? Let's play a memory game."
    puts "Match the cards!"
    sleep(3)
    until game_over?
      board.render
      #get_pos from the player
      begin
        puts "Select a position (e.g., 0 0)"
        print "> "
        make_guess(get_player_input)
      rescue => exception
        puts "Select a card that hasn't been flipped"
        retry
      end
      
    end
    puts "I guess your memory is pretty good :D"
  end

  def get_player_input
    pos = nil
      until pos && valid_pos?(pos)
        pos = gets.chomp.split.map(&:to_i)
        if !valid_pos?(pos)
          puts "Please enter a valid position on the board"
          print "> "
          pos = nil
        end
      end
    pos
  end

  def valid_pos?(pos)
    pos.is_a?(Array) && 
    pos.all? { |num| num.between?(0, board.size - 1) } &&
    pos.count == 2
  end

  def game_over?
    board.won?
  end

  #make_guess
  def make_guess(pos)
    #reveal the pos
    board.reveal(pos)
    board.render

    #compare the guess
    compare_guess(pos)

    #keep board displayed for a bit
    sleep(1)
    board.render
  end

  def compare_guess(new_guess)
    #compare if there is a previous_guess
    if previous_guess
      if match?(previous_guess, new_guess)
        puts "It's a match!"
      else
        puts "Try again."
        #hide the match
        [previous_guess, new_guess].each { |pos| board.hide(pos) }
      end
      #reset guess
      self.previous_guess = nil
    #else set the previous_guess to guess
    else
      self.previous_guess = new_guess
    end
  end

  def match?(pos1, pos2)
    board[pos1] == board[pos2]
  end

  private
  attr_reader :board
  attr_accessor :previous_guess

end