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
    elsif value < root.data
      root.left_child = insert(value, root.left_child)
    else value > root.data
      root.right_child = insert(value, root.right_child)
    end
    root
  end

  def delete(value, root = @root)
    return root if root.nil?

    if value < root.data
      root.left_child = delete(value, root.left_child)
    elsif value > root.data
      root.right_child = delete(value, root.right_child)
    else
      if root.left_child.nil?
        tmp = root.right_child
        root = nil
        return tmp
      elsif root.right_child.nil?
        tmp = root.left_child
        root = nil
        return tmp
      end
      tmp = min_value_node(root.right_child)
      root.data = tmp.data
      root.right_child = delete(tmp.data, root.right_child)
    end
    root
  end

  def min_value_node(node)
    current = node
    unless current.left_child.nil?
      current = current.left_child
    end
    current
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

tree.pretty_print

tree.insert(20)

tree.pretty_print

tree.delete(4)

tree.pretty_print
