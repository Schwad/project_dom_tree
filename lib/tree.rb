require_relative 'tag'
require 'pry'

class Tree
  attr_accessor :doc_string, :root
  def initialize(filename)
    @doc_string = File.open(filename, "r") {|f| f.read}
    cleanup_string

    @document = Tag.new("document", nil, nil, nil, @doc_string, [], nil)
    queue = [@document]
    until queue.empty?
      current_node = queue.shift
      while has_children?(current_node)
        child_name = /<(\w+)\s*.*>/.match(current_node.nested_text)[1]
        if /(<#{child_name}.*?>.*<\/#{child_name}>)/.match(current_node.nested_text).nil?
          binding.pry
        end
        child_string = /(<#{child_name}.*?>.*<\/#{child_name}>)/.match(current_node.nested_text)[1]
        child = create_child current_node, child_string
        current_node.children << child
        queue << child
        current_node.nested_text.gsub!(child_string,"")
      end
    end
  end

  def has_children?(node)
    node.nested_text =~ /</
  end

  # def start_index(node)
  #   node.nested_text =~ /</
  # end

  def create_child(parent_node, string)
    name = /<(\w+)\s*.*>/.match(string)[1]
    text = /<#{name}.*?>(.*?)</.match(string)[1]
    nested_text = /<#{name}.*?>(.*)<\/#{name}>/.match(string)[1]
    class_info = /<#{name} class="(.*?)">/.match(string)
    tag_class = class_info[1].split(" ") if class_info
    id_info = /<#{name} id="(.*?)">/.match(string)
    tag_id = id_info[1].split(" ") if id_info

    Tag.new(name,text,tag_class,tag_id,nested_text,[],parent_node)
  end

  def cleanup_string
    @doc_string.gsub!("<!doctype html>\n", "")
    @doc_string.gsub!(/\n\s*/, "")
  end
end