require_relative 'grid.rb'
require_relative 'poe.rb'

class Board
  def initialize
    @grid = Grid.new
    @winning_combinations = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                             [1, 4, 7], [2, 5, 8], [3, 6, 9],
                             [1, 5, 9], [3, 5, 7]].freeze
  end

  def make_move(position, marker)
    raise PositionOccupiedError.new(position, '') unless @grid.position_empty?(position)

    @grid.fill_position(position, marker)
  end

  def check_for_winning_combination(marker)
    winning_combination = false
    @winning_combinations.each do |arr|
      winning_combination = arr.all? do |position|
        grid_elem = @grid.element_at_position(position)
        equals_marker = grid_elem == marker
        break unless equals_marker

        equals_marker
      end

      break if winning_combination
    end

    winning_combination.nil? ? false : true
  end

  def solved?
    !@grid.any_positions_available?
  end

  def print_board
    str_board = ''
    str_board = append_new_line(str_board)

    @grid.grid.each_with_index do |x, _xi|
      x.each_with_index do |y, _yi|
        str_board = append_opening_bracket(str_board)
        str_board << (y.nil? ? ' ' : y.to_s)
        str_board = append_closing_bracket(str_board)
      end

      str_board = append_new_line(str_board)
    end

    append_new_line(str_board)
  end

  private

  def append_new_line(str)
    str << "\n"
  end

  def append_opening_bracket(str)
    str << '['
  end

  def append_closing_bracket(str)
    str << ']'
  end

  def append_whitespace(str)
    str << ' '
  end
end
