class ValidateCoordinatesError < StandardError; end
class MarsRover
  attr_accessor :x, :y, :direction
  DIRECTIONS = ['N', 'E', 'S', 'W']
  X_DIRECTIONS = {'E':1, 'W': -1}
  Y_DIRECTIONS = {'N':1, 'S': -1}

  def initialize(x, y, direction)
    @x = x
    @y = y
    @direction = direction
  end

  def move_forward(plateau_size)
    if moving_through_y?
      next_position = @y + Y_DIRECTIONS[@direction.to_sym]
      raise ValidateCoordinatesError, 'rover going outside the plateau' if next_position > plateau_size[:y].to_i
      
      @y = next_position
    elsif moving_through_x?
      next_position = @x + X_DIRECTIONS[@direction.to_sym]
      raise ValidateCoordinatesError, 'rover going outside the plateau' if next_position > plateau_size[:x].to_i
      
      @x = next_position
    end
  end

  def spin_left
    new_index = (DIRECTIONS.index(@direction) - 1)%4 
    @direction = DIRECTIONS[new_index]
  end

  def spin_right
    new_index = (DIRECTIONS.index(@direction) + 1)%4 
    @direction = DIRECTIONS[new_index]
  end
  
  private

  def moving_through_x?
    X_DIRECTIONS.keys.include?(@direction.to_sym)
  end

  def moving_through_y?
    Y_DIRECTIONS.keys.include?(@direction.to_sym)
  end
end
