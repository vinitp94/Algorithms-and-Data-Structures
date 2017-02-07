class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    res = 1
    each_with_index do |el, idx|
      res *= el.hash + idx.hash
    end
    res
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort.hash
  end
end
