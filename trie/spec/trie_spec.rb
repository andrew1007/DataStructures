require "rspec"
require "trie"

describe Trie do
  subject(:trie) {Trie.new}
  subject(:words) {["dog", "dogs", "state", "states", "stated", "abc", "abcd", "abcdef", "abcddef"]}
  before do 
    words.each { |word| trie.build(word)}
  end

  describe "#build" do
    it "add nodes with values" do
      check = words.map do |word|
        node_exist?(trie, word)
      end
      expect(check.all? {|i| i}).to be_truthy
    end
  end

  describe "#search?" do
    it "finds words" do
      check = words.map do |word|
        is_word_end?(trie, word)
      end
    end
    expect(check.all? {|i| i }).to be_truthy
  end

  # describe "delete" do
  #   it "should delete words by changing word_end" do
  #     trie.delete("dog")
  #     node_g = to_node(trie, "dog")
  #     expect(trie.search("dog"))
  #   end
  # end
end

def to_node(trie, str)
  current_node = trie.root
  str.each_char do |let|
    current_node = current_node.children[let]
    return false if current_node.val != let
  end
  current_node
end

def node_exist?(trie , str)
  current_node = trie.root
  str.each_char do |let|
    current_node = current_node.children[let]
    return false if current_node.val != let
  end
  true
end

def node_value?(trie , str)
  current_node = trie.root
  str.each_char do |let|
    current_node = current_node.children[let]
    return nil if current_node.children[let].nil?
  end
  current_node.val
end

def is_word_end?(trie, str)
  current_node = trie.root
  str.each_char do |let|
    current_node = current_node.children[let]
    return nil if current_node.children[let].nil?
  end
  current_node.word_end
end
