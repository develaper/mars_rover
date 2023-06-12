
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
    unavailable_coords = []

    @instructions.each_slice(2) do |position, instructions|
      rover = initialize_rover(position, unavailable_coords)
      move_rover(rover, instructions, unavailable_coords)

      deployed_rovers << rover
      unavailable_coords << [rover.x, rover.y]
    end

    deployed_rovers.map { |rover| "#{rover.x} #{rover.y} #{rover.direction}" }.join("\n")
  end

  private

  def initialize_rover(position, unavailable_coords=[])
    x, y, direction = position.split(' ')
    validate_initial_position(x, y, unavailable_coords)
    validate_initial_direction(direction)

    rover = MarsRover.new(x.to_i, y.to_i, direction)
  end
  
  def move_rover(rover, instructions, unavailable_coords=[])
    validate_instructions(instructions)

    instructions.chars.each do |instruction|
      case instruction
      when 'M'
        rover.move_forward(@size, unavailable_coords)
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

  def validate_initial_position(x, y, unavailable_coords)
    raise ValidateInputError, 'invalid initial position' if (x.to_i > @size[:x].to_i or y.to_i > @size[:y].to_i)
    raise ValidateInputError, 'invalid initial position' if unavailable_coords.include?([x.to_i, y.to_i])
  end

  def validate_instructions(instructions)
    invalid_instructions = instructions.gsub(/[[:space:]]/, "").split('').uniq - ['M','R','L']
    raise ValidateInputError, 'invalid instruction' if invalid_instructions.any?
  end

  def validate_initial_direction(direction)
    raise ValidateInputError, 'invalid direction' unless ['S', 'W', 'N', 'E'].include?(direction)
  end
end
