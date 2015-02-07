require "pry"
require_relative 'tree'

class DOMReader
  def build_tree(filename)
    Tree.new(filename)
  end
end