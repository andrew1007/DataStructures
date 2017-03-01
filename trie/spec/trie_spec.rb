require "rspec"
require "trie"
require_relative "spec_helper"

RSpec.configure do |config|
  config.include TrieHelper
end

describe Trie do
  subject(:trie) {Trie.new}
  subject(:words) {["dog", "dogged", "dogs", "state", "states", "stated", "abc", "abcd", "abcdef", "abcddef"]}
  subject(:mismatch) {["og", "dogd", "sta", "stateds", "ab"]}
  before do
    words.each { |word| trie.build(word)}
  end

  describe "#build" do
    it "add nodes with values" do
      check = words.map do |word|
        to_node(trie, word, "exists")
      end
      expect(check.all? {|i| i}).to be_truthy
    end
  end

  describe "#search?" do
    it "finds words" do
      check = words.map do |word|
        to_node(trie, word, "word_end")
      end
      expect(check.all? {|i| i }).to be_truthy
    end

    it "doesn't get false positives" do
      check = mismatch.map do |word|
        to_node(trie, word, "word_end")
      end
      expect(check.all? {|i| i }).to be_falsey
    end
  end

  describe "#delete" do
    it "deletes word by only changing word_end attribute" do
      # trie.delete("dog")
      # expect(trie.search("dog")).to be_falsey
      # expect(trie.search("dogs")).to be_truthy
    end

    it "deletes words and nodes specific to self" do
      trie.delete("dogged")
      e_exists = to_node(trie, "dogge", "exists")
      expect(trie.search("dog")).to be_truthy
      expect(e_exists).to be_falsey
      expect(trie.search("dogge")).to be_falsey
    end

    it "deletes words up to a node with multiple children" do
      trie.delete("abcdef")
      expect(trie.search("abcdef")).to be_falsey
      expect(trie.search("abcddef")).to be_truthy
    end
  end
end
