
require_relative 'mars_rover'
class ValidateInputError < StandardError; end
class Plateau
  attr_accessor :size, :instructions
  def initialize(input)
    lines = input.split("\n").compact
    first_line = lines.shift().gsub(/[[:space:]]/, "")
    validate_size(first_line)
    @size = {}
    @size[:x],@size[:y] = first_line.split('')
    @instructions = sanitize_lines(lines)
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
    validate_initial_position(x, y)

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

  def validate_size(first_line)
    raise ValidateInputError, 'invalid plateau size' unless /\A\d+\z/ === first_line
  end

  def sanitize_lines(lines)
    lines.each { |line| lines.delete(line) unless (line =~ /[[:alnum:]]/) }
  end

  def validate_initial_position(x, y)
    raise ValidateInputError, 'invalid initial position' if (x.to_i > @size[:x].to_i or y.to_i > @size[:y].to_i)
  end
end
