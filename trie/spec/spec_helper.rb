module TrieHelper
  def to_node(trie, str, property)
    current_node = trie.root
    str.each_char do |let|
      if property == "word_end"
        return false if current_node.children[let].nil?
      end
      current_node = current_node.children[let]
      case
      when "exists"
        if current_node.nil?
          return false
        end
      when "value"
        return false if current_node.val != let
      when "node"
        return false if current_node.nil?
      end
    end
    case property
    when "exists"
      return true
    when "value"
      return current_node.val
    when "word_end"
      return current_node.word_end
    when "node"
      return current_node
    end
  end
end
