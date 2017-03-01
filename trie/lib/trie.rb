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
    @root = Node.new(nil)
    @current_node = nil
  end

  def build(word)
    @current_node = @root
    word.each_char do |let|
      add_node(let) if child_exists?(let)
      @current_node = @current_node.children[let]
    end
    current_node.word_end = true
    return
  end

  def search(word)
    @current_node = @root
    word.each_char do |let|
      return nil if child_exists?(let)
      @current_node = next_node(let)
    end
    return nil if !@current_node.word_end
    return true
  end

  def delete(word)
    if search(word)
      if any_children?
        next_word_or_junction_up
        delete_node(word[-1])
      else
        @current_node.word_end = false
        return
      end
    end
  end

  private
  def add_node(let)
    @current_node.children[let] = Node.new(let, @current_node)
  end

  def next_word_or_junction_up
    while !@current_node.parent.word_end || multiple_children?
      @current_node = @current_node.parent
    end
  end

  def child_exists?(let)
    @current_node.children[let].nil?
  end

  def next_node(let)
    @current_node.children[let]
  end

  def any_children?
    @current_node.children.empty?
  end

  def delete_node(let)
    @current_node.children[let] = nil
    return
  end

  def is_word?
    @current_node.word_end
  end

  def multiple_children?
    @current_node.children.keys.count > 1
  end
end

trie = Trie.new
trie.build("dog")
trie.build("dogs")
trie.build("dogswd")
trie.build("dogsdw")
trie.delete("dog")
trie.search("dog")
trie.search("dogs")
trie.search("dogd")
trie.search("dogswd")
trie.search("dogsdw")
trie.delete("dogswd")
trie.search("dogswd")
trie.search("dogsdw")
