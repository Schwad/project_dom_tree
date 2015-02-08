class TreeSearcher
  def initialize(tree)
    @tree = tree
  end

  def search_by(type, value)
    case type
    when :name
      search_name(value)
    when :text
      search_text(value)
    when :id
      search_id(value)
    when :class
      search_class(value)
    end
  end

  def search_template(value)
    queue = [@tree.document]
    results = []
    until queue.empty?
      count_node = queue.shift
      if yield(count_node,value)
        results << count_node
      end
      queue += count_node.children.map { |child| child.dup }
    end
    return results
  end

  def search_name(value)
    search_template(value) { |node, value| node.name == value }
  end

  def search_text(value)
    search_template(value) { |node, value| node.text == value }
  end

  def search_id(value)
    search_template(value) do |node, value|
      !(node.id.nil?) && node.id.include?(value)
    end
  end

  def search_class(value)
    search_template(value) do |node, value|
      !(node.class.nil?) && node.class.include?(value)
    end
  end
end