class Robot
  attr_reader :table, :compass

  def initialize(table, compass = Compass.new)
    @table = table
    @compass = compass
  end

  def place(position, direction)
    direction = direction.to_s.upcase
    return unless valid_place?(position, direction)

    @position = position
    compass.direction = direction
  end

  def move
    return unless on_table?

    new_position = @position.move_to(compass.direction)
    @position = new_position if valid_position?(new_position)
  end

  def left
    compass.left if on_table?
  end

  def right
    compass.right if on_table?
  end

  def report
    "#{@position},#{compass.direction}" if on_table?
  end

  private

  def on_table?
    !!@position
  end

  def valid_place?(position, direction)
    valid_position?(position) && compass.valid_direction?(direction)
  end

  def valid_position?(position)
    table.within_bounds?(position)
  end
end
