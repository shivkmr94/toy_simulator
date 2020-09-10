class Position
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end

  def move_to(direction)
    self.send("to_#{direction.to_s.downcase}")
  end

  def to_north
    Position.new(x, y + 1)
  end

  def to_south
    Position.new(x, y - 1)
  end

  def to_east
    Position.new(x + 1, y)
  end

  def to_west
    Position.new(x - 1, y)
  end

  def to_s
    "#{x},#{y}"
  end
end
