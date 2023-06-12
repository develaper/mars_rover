require 'minitest/autorun'
require_relative 'mars_rover'
class MarsRoverTest < Minitest::Test
  def test_rover_init
    x = 0
    y = 3
    direction = 'S'
    rover = MarsRover.new(x, y, direction)
    assert_equal rover.x, x
    assert_equal rover.y, y
    assert_equal rover.direction, direction
  end

  #move_forward
  def test_prevent_plateau_overflow_to_north
    x = 5
    y = 5
    direction = 'N'
    plateau_size = {:x=>"5", :y=>"5"}
    rover = MarsRover.new(x, y, direction)
    assert_raises(ValidateCoordinatesError, 'rover going outside the plateau') { rover.move_forward(plateau_size) }
  end
  def test_prevent_plateau_overflow_to_east
    x = 5
    y = 5
    direction = 'E'
    plateau_size = {:x=>"5", :y=>"5"}
    rover = MarsRover.new(x, y, direction)
    assert_raises(ValidateCoordinatesError, 'rover going outside the plateau') { rover.move_forward(plateau_size) }
  end
  def test_rover_moves_south
    x = 0
    y = 3
    direction = 'S'
    plateau_size = {:x=>"5", :y=>"5"}
    rover = MarsRover.new(x, y, direction)
    rover.move_forward(plateau_size)
    assert_equal rover.x, x
    assert_equal rover.y, (y-1)
  end
  
  def test_rover_moves_north
    x = 0
    y = 3
    direction = 'N'
    plateau_size = {:x=>"5", :y=>"5"}
    rover = MarsRover.new(x, y, direction)
    rover.move_forward(plateau_size)
    assert_equal rover.x, x
    assert_equal rover.y, (y+1)
  end

  def test_rover_moves_east
    x = 0
    y = 3
    direction = 'E'
    plateau_size = {:x=>"5", :y=>"5"}
    rover = MarsRover.new(x, y, direction)
    rover.move_forward(plateau_size)
    assert_equal rover.x, (x+1)
    assert_equal rover.y, y
  end

  def test_rover_moves_west
    x = 0
    y = 3
    direction = 'W'
    plateau_size = {:x=>"5", :y=>"5"}
    rover = MarsRover.new(x, y, direction)
    rover.move_forward(plateau_size)
    assert_equal rover.x, (x-1)
    assert_equal rover.y, y
  end

  #spin_left
  def test_spin_left_when_heading_south
    x = 3
    y = 3
    direction = 'S'
    rover = MarsRover.new(x, y, direction)
    rover.spin_left
    assert_equal rover.direction, 'E'
  end

  def test_spin_left_when_heading_north
    x = 3
    y = 3
    direction = 'N'
    rover = MarsRover.new(x, y, direction)
    rover.spin_left
    assert_equal rover.direction, 'W'
  end

  def test_spin_left_when_heading_east
    x = 3
    y = 3
    direction = 'E'
    rover = MarsRover.new(x, y, direction)
    rover.spin_left
    assert_equal rover.direction, 'N'
  end

  def test_spin_left_heading_west
    x = 3
    y = 3
    direction = 'W'
    rover = MarsRover.new(x, y, direction)
    rover.spin_left
    assert_equal rover.direction, 'S'
  end

  #spin_right
  def test_spin_right_when_heading_south
    x = 3
    y = 3
    direction = 'S'
    rover = MarsRover.new(x, y, direction)
    rover.spin_right
    assert_equal rover.direction, 'W'
  end

  def test_spin_right_when_heading_north
    x = 3
    y = 3
    direction = 'N'
    rover = MarsRover.new(x, y, direction)
    rover.spin_right
    assert_equal rover.direction, 'E'
  end

  def test_spin_right_when_heading_east
    x = 3
    y = 3
    direction = 'E'
    rover = MarsRover.new(x, y, direction)
    rover.spin_right
    assert_equal rover.direction, 'S'
  end

  def test_spin_right_heading_west
    x = 3
    y = 3
    direction = 'W'
    rover = MarsRover.new(x, y, direction)
    rover.spin_right
    assert_equal rover.direction, 'N'
  end
end