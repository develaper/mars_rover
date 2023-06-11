require 'minitest/autorun'
require_relative 'plateau'
class PlateauTest < Minitest::Test
  def test_plateau_init
    input = "5 5\n1 2 N\nL M L M L M L M M\n3 3 E\nM M R M M R M R R M"
    plateau = Plateau.new(input)
    assert_equal 55, plateau.size
  end
  def test_deploy_rovers
    input = "5 5\n1 2 N\nL M L M L M L M M\n3 3 E\nM M R M M R M R R M"
    final_positions = Plateau.new(input).deploy_rovers
    assert_equal "1 3 N\n5 1 E", final_positions
  end
end