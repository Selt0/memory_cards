class Player
  
attr_accessor :previous_guess
attr_reader :name

  def initialize(_size)
    @previous_guess = nil
  end

  def get_move
    prompt
    parse(STDIN.gets.chomp)
  end

  def prompt
    puts "Select a position (e.g., 0 0)"
    print "> "
  end

  def parse(string)
    string.split.map(&:to_i)
  end

  #duck typing
  def receive_match(_pos1, _pos2)
    puts "It's a match!"
  end

  def reveive_revealed_cards(pos, val)
  end
end