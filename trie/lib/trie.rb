class Node
  attr_accessor :val, :children, :word_end, :parent
  def initialize(val, parent = nil, word_end = false)
    @val = val
    @children = {}
    @word_end = word_end
    @parent = parent
  end
end

class Trie
  attr_accessor :root, :current_node
  def initialize
    @root = Node.new(nil, nil, true)
    @current_node = nil
  end

  def build(word)
    @current_node = @root
    word.each_char do |let|
      add_node(let) if !child_exists?(let)
      @current_node = @current_node.children[let]
    end
    current_node.word_end = true
    return
  end

  def search(word)
    @current_node = @root
    word.each_char do |let|
      return nil if !child_exists?(let)
      @current_node = next_node(let)
    end
    return nil if !@current_node.word_end
    return true
  end

  def delete(word)
    if search(word)
      if any_children?
        @current_node.word_end = false
      else
        p true
        delete_node
      end
    end
  end

  # private
  def add_node(let)
    @current_node.children[let] = Node.new(let, @current_node)
  end

  def delete_node
    while !multiple_children?(@current_node) || !@current_node.word_end
      current_node_val = @current_node.val
      @current_node = @current_node.parent
      @current_node.children[current_node_val] = nil
    end
  end

  def child_exists?(let)
    !@current_node.children[let].nil?
  end

  def prev_node(node)
    @current_node = node.parent
  end

  def next_node(let)
    @current_node.children[let]
  end

  def any_children?
    !@current_node.children.empty?
  end

  def is_word?
    @current_node.word_end
  end

  def multiple_children?(node)
    node.children.keys.count > 1
  end
end
