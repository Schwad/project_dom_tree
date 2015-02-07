require "pry"

class DOMReader
  attr_accessor :doc_string

  def build_tree(filename)
    @doc_string = File.open(filename, "r") {|f| f.read}
    @doc_string.gsub!("<!doctype html>\n", "")
    @doc_string.gsub!(/\n\s*/, "")
  end
end