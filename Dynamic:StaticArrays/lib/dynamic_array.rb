require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" unless length > 0
    last = self[length - 1]
    self[length - 1] = nil
    self.length -= 1
    last
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length == capacity
    self.length += 1
    self[length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length == 0
    temp = self[0]
    (1...length).each { |idx| self[idx - 1] = self[idx] }
    self.length -= 1
    temp
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == capacity
    self.length += 1
    (length - 2).downto(0).each { |idx| self[idx + 1] = self[idx] }
    self[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless index >= 0 && index < length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    self.capacity *= 2
    new_store = StaticArray.new(capacity)
    length.times { |idx| new_store[idx] = self[idx] }
    self.store = new_store
  end
end
