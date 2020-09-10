class Compass < Base
  DIRECTIONS = %w(NORTH EAST SOUTH WEST).freeze

  attr_reader :direction

  def initialize
    @direction = DIRECTIONS.first
  end

  def direction=(direction)
    return unless valid_direction?(direction)

    @direction = direction
  end

  def valid_direction?(direction)
    DIRECTIONS.include?(direction)
  end

  def left
    rotate(-1)
  end

  def right
    rotate(1)
  end

  def to_s
    value
  end

  DIRECTIONS.each do |direction|
    define_method "#{direction.downcase}?" do
      value == direction
    end
  end

  private

  def rotate(count)
    index = DIRECTIONS.index(direction)
    @direction = DIRECTIONS.rotate(count)[index]
  end
end
