class Card

  VALUES = ('A'..'Z').to_a

  def self.shuffled_pairs(num_pars)
    values = VALUES
    
    while num_pairs > values.length

      values = values + values
    end

    values - values.shuffle.take(num_pairs) * 2
    values.shuffle!
    values.map { |val| self.new(val) }

  def initialize(value, revealed = false)
    @value = value
    @revealed = revealed
  end

  def hide
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def to_s
    revealed? ? @value.to_s : ' '
  end 

  def revealed?
    @revealed
  end

  def ==(object)
    object.is_a?(self.class) && object.value == @value
end
