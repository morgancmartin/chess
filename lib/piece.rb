# Piece class defines a piece in general
class Piece
  attr_accessor :location
  def initialize(location = [0, 0])
    @location = location
    @reach = 1
    @possible_directions = [:north, :south, :east, :west,
                            :northeast, :northwest, :southeast, :southwest]
  end

  # Calculates possible moves based on possible_directions and reach.
  def possible_moves
    moves = []
    @reach.downto(-@reach) {|num| moves << num}
    moves = moves.repeated_permutation(2).to_a
    moves = apply_directions(moves)
    apply_location(moves)
  end

  # Applies location to possible moves
  def apply_location(moves)
    moves.map { |move| [(move[0] + @location[0]), (move[1] + @location[1])]}
  end

  # Filters possible moves with possible_directions
  def apply_directions(moves)
    moves.delete_if { |move| move == @location }
    moves.delete_if { |move| northern_move?(move) } unless @possible_directions.include?(:north)
    moves.delete_if { |move| southern_move?(move) } unless @possible_directions.include?(:south)
    moves.delete_if { |move| eastern_move?(move) } unless @possible_directions.include?(:east)
    moves.delete_if { |move| western_move?(move) } unless @possible_directions.include?(:west)
    moves.delete_if { |move| northeastern_move?(move) } unless @possible_directions.include?(:northeast)
    moves.delete_if { |move| northwestern_move?(move) } unless @possible_directions.include?(:northwest)
    moves.delete_if { |move| southeastern_move?(move) } unless @possible_directions.include?(:southeast)
    moves.delete_if { |move| southwestern_move?(move) } unless @possible_directions.include?(:southwest)
    moves
  end

  def northern_move?(move)
    move[0] == 0 && move[1] > 0
  end

  def southern_move?(move)
    move[0] == 0 && move[1] < 0
  end

  def eastern_move?(move)
    move[0] < 0 && move[1] == 0
  end

  def western_move?(move)
    move[0] > 0 && move[1] == 0
  end

  def northeastern_move?(move)
    move[0] > 0 && move[1] > 0
  end

  def northwestern_move?(move)
    move[0] < 0 && move[1] > 0
  end

  def southeastern_move?(move)
    move[0] > 0 && move[1] < 0
  end

  def southwestern_move?(move)
    move[0] < 0 && move[1] < 0
  end
end


class Pawn < Piece
  def initialize(location = [0, 0])
    @location = location
    @reach = 1
    @possible_directions = [:north]
  end
end


class Knight < Piece
  def initialize(location = [0, 0])
    @location = location
  end

  def possible_moves
    moves = [[-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1]]
    apply_location(moves)
  end
end


class Bishop < Piece
  def initialize(location = [0, 0])
    @location = location
    @reach = 7
    @possible_directions = [:northeast, :northwest,
                            :southeast, :southwest]
  end
end


class Rook < Piece
  def initialize(location = [0, 0])
    @location = location
    @reach = 7
    @possible_directions = [:north, :south, :east, :west]
  end
end


class Queen < Piece
  def initialize(location = [0, 0])
    @location = location
    @reach = 7
    @possible_directions = [:north, :south, :east, :west,
                            :northeast, :northwest, :southeast, :southwest]
  end
end


class King < Piece
  def initialize(location = [0, 0])
    @location = location
    @reach = 1
    @possible_directions = [:north, :south, :east, :west,
                            :northeast, :northwest, :southeast, :southwest]
  end
end
