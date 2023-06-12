require 'minitest/autorun'
require_relative 'plateau'
class PlateauTest < Minitest::Test
  def test_plateau_init
    input = "5 5\n1 2 N\nL M L M L M L M M\n3 3 E\nM M R M M R M R R M"
    expected_size = {:x=>"5", :y=>"5"}
    plateau = Plateau.new(input)
    assert_equal expected_size, plateau.size
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

  def test_deploy_rovers_with_position_outside_of_the_plateau
    input = "5 5\n6 6 N\nL M L M L M L M M\n3 3 E\nM M R M M R M R R M"
    assert_raises(ValidateInputError, 'invalid initial position') { Plateau.new(input).deploy_rovers }
  end

  def test_deploy_rovers_with_poluted_instructions
    input = "5 5\n1 2 N\nL M L M X J K W Q L M L M M\n3 3 E\nM M R M M R M R R M"
    assert_raises(ValidateInputError, 'invalid instruction') { Plateau.new(input).deploy_rovers }
  end
end