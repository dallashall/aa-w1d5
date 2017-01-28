require_relative "00_tree_node"
class KnightPathFinder
  MOVEMENT = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]]
  attr_reader :visited_positions

  def initialize(start_pos == [0,0])
    @start_pos = start_pos
    @visited_positions = [@start_pos]
    @tree_hash = {}
  end

  # def new_move_positions(pos)
  #   moves = KnightPathFinder.valid_moves(pos).reject do |move|
  #     @visited_positions.include?(move)
  #   end
  #   @visited_positions += moves
  #   moves
  # end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos).reject do |move|
      @visited_positions.include?(move)
    end
    moves
  end

  def self.valid_moves(pos)
    moves = MOVEMENT.map { |move| [move[0] + pos[0], move[1] + pos[1]] }
    moves.select do |move|
      move[0].between?(0, 8) && move[1].between?(0, 8)
    end
  end

  def build_move_tree
    q = [PolyTreeNode.new(@start_pos)]
    q.each do |pos_node|
      new_move_positions(pos_node.value).each do |possible_pos|
        pos_node.add_child(PolyTreeNode.new(possible_pos))
      end

      @visited_positions << pos
      @tree_hash[pos.value.to_s] = trace_back(q.shift)
    end
  end

  def trace_back(pos_node)
    path = []
    until pos_node.parent.nil?
      path.unshift(pos_node.parent.value)
      pos_node = pos_node.parent
    end
    pos_node
end
