require "pry"
require_relative 'tag'

class DOMReader
  attr_accessor :doc_string, :root
  
  def build_tree(filename)
    @doc_string = File.open(filename, "r") {|f| f.read}
    @doc_string.gsub!("<!doctype html>\n", "")
    @doc_string.gsub!(/\n\s*/, "")
    name = @doc_string.match(/^<(\w)\s*.*>/)
    @root = Tag.new(name)
  end

end





