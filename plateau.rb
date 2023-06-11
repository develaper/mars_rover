
require_relative 'mars_rover'
class Plateau
  attr_accessor :size, :instructions
  def initialize(input)
    lines = input.split("\n").compact
    @size = lines.shift().gsub(/[[:space:]]/, "").to_i
    @instructions = lines
  end

  def deploy_rovers
    deployed_rovers = []

    @instructions.each_slice(2) do |position, instructions|
      rover = initialize_rover(position)
      move_rover(rover, instructions)

      deployed_rovers << rover
    end

    deployed_rovers.map { |rover| "#{rover.x} #{rover.y} #{rover.direction}" }.join("\n")
  end

  private

  def initialize_rover(position)
    x, y, direction = position.split(' ')
    rover = MarsRover.new(x.to_i, y.to_i, direction)
  end
  
  def move_rover(rover, instructions)
    instructions.chars.each do |instruction|
      case instruction
      when 'M'
        rover.move_forward
      when 'L'
        rover.spin_left
      when 'R'
        rover.spin_right
      end
    end
  end
end
