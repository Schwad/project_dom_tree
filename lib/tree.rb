require_relative 'tag'
require 'pry'

class Tree
  attr_accessor :doc_string, :root
  def initialize(filename)
    @doc_string = File.open(filename, "r") {|f| f.read}

    # extract these scrubbing lines into one method
    @doc_string.gsub!("<!doctype html>\n", "")
    @doc_string.gsub!(/\n\s*/, "")

    name = /^<(\w+)\s*.*>/.match(@doc_string)[1]
    text = /<#{name}.*>(.*?)<\/#{name}>/.match(@doc_string)[1]
    @root = Tag.new(name,text)
  end
end