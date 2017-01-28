require_relative "00_tree_node"
class KnightPathFinder
  MOVEMENT = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]]
  attr_reader :visited_positions

  def initialize(start_pos == [0,0])
    @start_pos = start_pos
    @visited_positions = [@start_pos]
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos).reject do |move|
      @visited_positions.include?(move)
    end
    @visited_positions += moves
    moves
  end

  def self.valid_moves(pos)
    moves = MOVEMENT.map { |move| [move[0] + pos[0], move[1] + pos[1]] }
    moves.select do |move|
      move[0].between?(0, 8) && move[1].between?(0, 8)
    end
  end

  def build_move_tree
    # cur_node = PolyTreeNode(@start_pos)
    # move_tree = [cur_node]
    #
    # until cur_node ==

  end


end
