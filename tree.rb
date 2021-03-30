# Frozen_string_literal: true.

require_relative 'node'

# Class defining the methods necessary to create a balanced binary search tree.
class Tree
  def initialize(array)
    @root = build_tree(sort_array(array))
  end

  def sort_array(array)
    array.uniq.sort
  end

  def build_tree(array)
    return if array.length == 0
    mid = array.length / 2
    root = Node.new(array[mid])
    root.left_child = build_tree(array[0...mid])
    root.right_child = build_tree(array[mid+1..-1])
    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
