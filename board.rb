require_relative 'card'

class Board

  attr_reader :grid, :size

  def initialize(size = 4)
    @grid = Array.new(size){ Array.new(size) }
    @size = size
    populate
  end
  
  def [](pos)
    x,y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    grid[x][y] = value
  end

  def render
    system("clear")
    puts "  #{(0...size).to_a.join(' ')}"
    grid.each_with_index { |row, i|puts "#{i} #{row.join(' ')}" }
  end

  def populate
    num_pairs = (size ** 2) / 2
    cards = Card.shuffled_pairs(num_pairs)

    grid.each_index do |i|
      grid[i].each_index do |j|
        self[[i, j]] = cards.pop
      end
    end
  end
end