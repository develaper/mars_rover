require 'minitest/autorun'
require_relative 'plateau'
class PlateauTest < Minitest::Test
  def test_plateau_init
    input = "5 5\n1 2 N\nL M L M L M L M M\n3 3 E\nM M R M M R M R R M"
    plateau = Plateau.new(input)
    assert_equal 55, plateau.size
  end
  def test_validate_size_with_no_numbers
    input = "Q W\n1 2 N\nL M L M L M L M M\n3 3 E\nM M R M M R M R R M"
    assert_raises(ValidateInputError, 'invalid plateau size') { Plateau.new(input) }
  end
  def test_validate_size_with_negative_numbers
    input = "-55\n1 2 N\nL M L M L M L M M\n3 3 E\nM M R M M R M R R M"
    assert_raises(ValidateInputError, 'invalid plateau size') { Plateau.new(input) }
  end
  def test_deploy_rovers
    input = "5 5\n1 2 N\nL M L M L M L M M\n3 3 E\nM M R M M R M R R M"
    final_positions = Plateau.new(input).deploy_rovers
    assert_equal "1 3 N\n5 1 E", final_positions
  end
  def test_deploy_rovers_with_poluted_input
    input = "5 5\n1 2 N\nL M L M L M L M M\n3 3 E\nM M R M M R M R R M"
    final_positions = Plateau.new(input).deploy_rovers
    poluted_input = "5 5\n __$ \n1 2 N\n\nL M L M L M L M M\n  \n3 3 E\nM M R M M R M R R M"
    poluted_final_positions = Plateau.new(poluted_input).deploy_rovers
    assert_equal final_positions, poluted_final_positions
  end
end