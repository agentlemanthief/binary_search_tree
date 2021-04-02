# Frozen_string_literal: true

require_relative 'tree'

tree = Tree.new(Array.new(15) { rand(1..100) })

tree.pretty_print

puts tree.balanced? ? "\nThe tree is balanced\n" : "\nThe tree is not balanced"

puts "\nLevel-order traversal array: #{tree.level_order}"

puts "\nPre-order traversal array: #{tree.preorder}"

puts "\nPost-order traversal array: #{tree.postorder}"

puts "\nIn-order traversal array: #{tree.inorder}"

puts "\nInserting elements..."
tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.insert(104)
tree.insert(105)
tree.insert(106)

puts tree.balanced? ? "\nThe tree is balanced\n" : "\nThe tree is not balanced\n\n"

tree.pretty_print

puts "\nRebalancing the tree...\n\n"
tree.rebalance

tree.pretty_print

puts tree.balanced? ? "\nThe tree is balanced\n" : "\nThe tree is not balanced"

puts "\nLevel-order traversal array: #{tree.level_order}"

puts "\nPre-order traversal array: #{tree.preorder}"

puts "\nPost-order traversal array: #{tree.postorder}"

puts "\nIn-order traversal array: #{tree.inorder}"
