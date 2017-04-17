class Node
  attr_accessor :val, :children, :word_end, :parent
  def initialize(val, left = nil, right = nil, parent = nil)
    @val = val
    @left = left
    @right = right
    @parent = parent
  end
end

class DFS
  def initialize
    @root = root
  end

  def depth_first_search(node = @root, target)
      if node.val == target
          puts "yes"
          return node
      end
      left = depth_first_search(node.left, target) if node.left
      right = depth_first_search(node.right, target) if node.right
      left || right
  end
end
