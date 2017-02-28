class Node
  attr_accessor :val, :children, :word_end, :parent
  def initialize(val, parent = nil, next_node = nil, word_end = false)
    @val = val
    @children = {}
    @word_end = word_end
    @parent = parent
  end
end

class Trie
  attr_accessor :root, :current_node
  def initialize
    @root = Node.new(nil)
    @current_node = nil
  end

  def build(word)
    current_node = @root
    word.each_char do |let|
      add_node(current_node, let) if current_node.children[let].nil?
      current_node = current_node.children[let]
    end
    current_node.word_end = true
    return
  end

  def add_node(node, let)
    node.children[let] = Node.new(let, node)
  end

  def search(word)
    current_node = @root
    word.each_char do |let|
      if current_node.children[let].nil?
        @current_node = nil
        return nil
      end
      current_node = current_node.children[let]
    end
    if !current_node.word_end
      @current_node = nil
      return nil
    end
    @current_node = current_node
    return true
  end

  def delete(word)
    if search(word)
      if @current_node.children.empty?
        next_node = next_word_up(@current_node)
        next_node.children[word[-1]] = nil
      else
        @current_node.word_end = false
        return
      end
    end
  end

  def next_word_up(node)
    current_node = node
    while !current_node.parent.word_end
      current_node = current_node.parent
    end
    return current_node
  end
end

trie = Trie.new
trie.build("dog")
trie.build("dogs")
trie.build("dogswd")
trie.delete("dog")
trie.search("dogs")
trie.search("dogd")
trie.search("dogswd")
trie.delete("dogswd")
