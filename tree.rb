# Frozen_string_literal: true.

require_relative 'node'

# Class defining the methods necessary to create a balanced binary search tree.
class Tree
  attr_reader :root

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

  def insert(value, root = @root)
    return Node.new(value) if root.nil?
    if root.data == value
      root
    elsif root.data > value
      root.left_child = insert(value, root.left_child)
    else root.data < value
      root.right_child = insert(value, root.right_child)
    end
    root
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

tree.pretty_print

tree.insert(20)

tree.pretty_print
