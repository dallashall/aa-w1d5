require "byebug"
class PolyTreeNode
  attr_reader :value, :parent, :children
  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    if node && (node != @parent)
      @parent.remove_child(self) if @parent
      node.add_child(self)
    end
    @parent = node
  end

  def remove_from_parent
    @parent.remove_child(self)
  end

  def add_child(node)
    unless @children.include?(node)
      @children << node
      node.parent = (self)
    end
  end

  def remove_child(node)
    raise "node is not a child!" unless node && @children.include?(node)
    @children -= [node]
    node.parent = nil
  end

  def dfs(value)
    return self if self.value == value
    @children.each do |child|
      results = child.dfs(value)
      return results if results
    end
    nil
  end

  def bfs(value)
    q = [self]
    # NOTE: This is an awesome funky way of doing this.
    # q.each do |node|
    #   return node if node.value == value
    #   node.children.each { |child| q << child }
    # end

    until q.empty?
      curr = q.shift
      return curr if curr.value == value
      q += curr.children
    end
    nil
  end



end
