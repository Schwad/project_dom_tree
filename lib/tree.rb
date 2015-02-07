require_relative 'tag'
require 'pry'

class Tree
  attr_accessor :doc_string, :root
  def initialize(filename)
    @doc_string = File.open(filename, "r") {|f| f.read}
    cleanup_string

    name = /^<(\w+)\s*.*>/.match(@doc_string)[1]
    text = /<#{name}.*?>(.*?)</.match(@doc_string)[1]
    nested_text = /<#{name}.*?>(.*?)<\/#{name}>/.match(@doc_string)[1]
    @root = Tag.new(name,text,nil,nil,nested_text)
  end

  def cleanup_string
    @doc_string.gsub!("<!doctype html>\n", "")
    @doc_string.gsub!(/\n\s*/, "")    
  end
end

#:class,:id,:children,:parent)
#NSFW 
