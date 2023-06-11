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

  def move_forward
    if moving_through_y?
      @y = @y + Y_DIRECTIONS[@direction.to_sym]
    elsif moving_through_x?
      @x = @x + X_DIRECTIONS[@direction.to_sym]
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
