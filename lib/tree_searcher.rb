class TreeSearcher
  def initialize(tree)
    @tree = tree
  end

  def search_by(type, value)
    case type
    when :name
      search_name(@tree.document, value)
    when :text
      search_text(@tree.document, value)
    when :id
      search_id(@tree.document, value)
    when :class
      search_class(@tree.document, value)
    end
  end

  def search_template(start_node,value)
    queue = [start_node]
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

  def search_name(start_node,value)
    search_template(start_node,value) do |node, value|
      node.name == value
    end
  end

  def search_text(start_node,value)
    search_template(start_node,value) do |node, value|
      node.text == value
    end
  end

  def search_id(start_node,value)
    search_template(start_node,value) do |node, value|
      !(node.id.nil?) && node.id.include?(value)
    end
  end

  def search_class(start_node,value)
    search_template(start_node,value) do |node, value|
      !(node.class.nil?) && node.class.include?(value)
    end
  end

  def search_children(node, type, value)
    case type
    when :name
      search_name(node, value)
    when :text
      search_text(node, value)
    when :id
      search_id(node, value)
    when :class
      search_class(node, value)
    end
  end

  def search_ancestors(node, type, value)
    case type
    when :name
      ancestor_search_name(node, value)
    when :text
      ancestor_search_text(node, value)
    when :id
      ancestor_search_id(node, value)
    when :class
      ancestor_search_class(node, value)
    end
  end

  def ancestor_search_template(node, value)
    results = []
    until node.parent.nil?
      if yield(node, value)
        results << node
      end
      node = node.parent
    end
    results
  end

  def ancestor_search_name(node, value)
    ancestor_search_template(node, value) do |node, value|
      node.name == value
    end
  end

  def ancestor_search_text(start_node,value)
    ancestor_search_template(start_node,value) do |node, value|
      node.text == value
    end
  end

  def ancestor_search_id(start_node,value)
    ancestor_search_template(start_node,value) do |node, value|
      !(node.id.nil?) && node.id.include?(value)
    end
  end

  def ancestor_search_class(start_node,value)
    ancestor_search_template(start_node,value) do |node, value|
      !(node.class.nil?) && node.class.include?(value)
    end
  end
end