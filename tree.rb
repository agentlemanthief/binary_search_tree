# Frozen_string_literal: true

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
    return if array.empty?

    mid = array.length / 2
    root = Node.new(array[mid])
    root.left_child = build_tree(array[0...mid])
    root.right_child = build_tree(array[mid + 1..-1])
    root
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
    else
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
      del_if_two_child(root)
    end
    root
  end

  def del_if_two_child(root)
    tmp = min_value_node(root.right_child)
    root.data = tmp.data
    root.right_child = delete(tmp.data, root.right_child)
  end

  def min_value_node(node)
    current = node
    current = current.left_child unless current.left_child.nil?
    current
  end

  def find(value, root = @root)
    return root if root.data == value

    if value < root.data
      find(value, root.left_child)
    elsif value > root.data
      find(value, root.right_child)
    end
  rescue NoMethodError
    puts 'Value not found!'
  end

  def level_order(root = @root)
    result = []
    queue = [root]
    until queue.empty?
      root = queue.shift
      result << root.data
      queue << root.left_child unless root.left_child.nil?
      queue << root.right_child unless root.right_child.nil?
    end
    result
  end

  def inorder(root = @root, result = [])
    return if root.nil?

    inorder(root.left_child, result)
    result << root.data
    inorder(root.right_child, result)
    result
  end

  def preorder(root = @root, result = [])
    return if root.nil?

    result << root.data
    preorder(root.left_child, result)
    preorder(root.right_child, result)
    result
  end

  def postorder(root = @root, result = [])
    return if root.nil?

    postorder(root.right_child, result)
    postorder(root.left_child, result)
    result << root.data
    result
  end

  def height(node = @root)
    return -1 if node.nil?

    [height(node.left_child), height(node.right_child)].max + 1
  end

  def depth(node)
    if node.data < @root.data
      height(@root.left_child) - height(node) + 1
    else
      height(@root.right_child) - height(node) + 1
    end
  end

  def balanced?
    (height(@root.left_child) - height(@root.right_child)).abs <= 1
  end

  def rebalance
    @root = build_tree(sort_array(level_order))
  end
end
