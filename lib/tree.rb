require_relative 'tag'
require 'pry'

class Tree
  attr_accessor :doc_string, :root
  def initialize(filename)
    @doc_string = File.open(filename, "r") {|f| f.read}
    cleanup_string

    @document = Tag.new("document", nil, nil, nil, @doc_string)
    queue = [@document]
    until queue.empty?
      current_node = queue.shift
      if has_children?(current_node)  
        #break the nested text into children
        #create child node for each tag 
        #add child node to current_node's child array
      end

      #add new children tags to queue
    end
  end

  def has_children?(node)
    node.nested_text =~ /</
  end

  def create_child(parent_node, string)
    name = /^<(\w+)\s*.*>/.match(string)[1]
    text = /<#{name}.*?>(.*?)</.match(string)[1]
    nested_text = /<#{name}.*?>(.*?)<\/#{name}>/.match(string)[1]
    class_info = /<#{name} class="(.*?)">/.match(string)
    tag_class = class_info[1].split(" ") if class_info
    id_info = /<#{name} id="(.*?)">/.match(string)
    tag_id = id_info[1].split(" ") if id_info

    Tag.new(name,text,tag_class,tag_id,nested_text,nil,parent_node)
  end

  def cleanup_string
    @doc_string.gsub!("<!doctype html>\n", "")
    @doc_string.gsub!(/\n\s*/, "")
  end
end