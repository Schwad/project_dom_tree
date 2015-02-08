require_relative 'tree'

class NodeRenderer

  attr_accessor :tag_counts

  def initialize(tree)
    @tree = tree
  end

  def render(node)
    puts "Name: #{node.name}"
    puts "Class(es): #{node.class.join(",")}" if node.class
    puts "ID(s): #{node.id.join(",")}" if node.id
    puts "Text: #{node.text}" if node.text

    queue = node.children.map { |child| child.dup }
    @tag_counts = {}

    until queue.empty?
      count_node = queue.shift
      queue += count_node.children.map { |child| child.dup }
      if @tag_counts.has_key? count_node.name
        @tag_counts[count_node.name] += 1
      else
        @tag_counts[count_node.name] = 1
      end
    end

    sum = 0
    @tag_counts.values.each do |value|
      sum += value
    end
    puts "total child nodes: #{sum}"

    @tag_counts.each do |tag, count|
      puts "#{tag}: #{count}"
    end
  end

end