class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @left = nil
    @right = nil
    @value = value
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
    else
      BinarySearchTree.insert!(@root, value)
    end
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    @root = BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) if node.nil?

    if value <= node.value
      node.left = BinarySearchTree.insert!(node.left, value)
    else
      node.right = BinarySearchTree.insert!(node.right, value)
    end

    node
  end

  def self.find!(node, value)
    return nil if node.nil?
    return node if node.value == value

    if value < node.value
      BinarySearchTree.find!(node.left, value)
    else
      BinarySearchTree.find!(node.right, value)
    end
  end

  def self.preorder!(node)
    return [] if node.nil?

    arr = [node.value]
    arr += BinarySearchTree.preorder!(node.left) if node.left
    arr += BinarySearchTree.preorder!(node.right) if node.right

    arr
  end

  def self.inorder!(node)
    return [] if node.nil?

    arr = []
    arr += BinarySearchTree.inorder!(node.left) if node.left
    arr << node.value
    arr += BinarySearchTree.inorder!(node.right) if node.right

    arr
  end

  def self.postorder!(node)
    return [] if node.nil?

    arr = []
    arr += BinarySearchTree.postorder!(node.left) if node.left
    arr += BinarySearchTree.postorder!(node.right) if node.right
    arr << node.value

    arr
  end

  def self.height!(node)
    return -1 if node.nil?

    [BinarySearchTree.height!(node.left), BinarySearchTree.height!(node.right)].max + 1
  end

  def self.max(node)
    return nil if node.nil?
    return node if node.right.nil?

    BinarySearchTree.max(node.right)
  end

  def self.min(node)
    return nil if node.nil?
    return node if node.left.nil?

    BinarySearchTree.min(node.left)
  end

  def self.delete_min!(node)
    return nil if node.nil?
    return node.right if node.left.nil?

    node.left = BinarySearchTree.delete_min!(node.left)

    node
  end

  def self.delete!(node, value)
    return nil if node.nil?

    if value < node.value
      node.left = BinarySearchTree.delete!(node.left, value)
    elsif value > node.value
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      return node.left if node.right.nil?
      return node.right if node.left.nil?

      temp = node
      node = temp.right.min
      node.right = BinarySearchTree.delete_min!(temp.right)
      node.left = temp.left
    end

    node
  end
end
