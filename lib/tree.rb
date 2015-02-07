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
    class_info = /<#{name} class="(.*?)">/.match(@doc_string)
    tag_class = class_info[1].split(" ") if class_info
    id_info = /<#{name} id="(.*?)">/.match(@doc_string)
    tag_id = id_info[1].split(" ") if id_info
    # binding.pry

    @root = Tag.new(name,text,tag_class,tag_id,nested_text)
  end

  def cleanup_string
    @doc_string.gsub!("<!doctype html>\n", "")
    @doc_string.gsub!(/\n\s*/, "")
  end
end