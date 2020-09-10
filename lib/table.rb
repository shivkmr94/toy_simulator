class Table < Base
  attr_reader :width, :height

  def initialize(width=5, height=5)
    @width = width
    @height = height
  end

  def within_bounds?(position)
    valid_x?(position.x) && valid_y?(position.y)
  end

  private

  def valid_x?(x)
    x >= 0 && x < width
  end

  def valid_y?(y)
    y >= 0 && y < height
  end
end
