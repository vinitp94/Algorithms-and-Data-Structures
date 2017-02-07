class BinaryMinHeap
  def initialize(&prc)
    self.store = []
    self.prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
  end

  def count
    store.length
  end

  def extract
    rails 'no element to extract' if count == 0
    val = store[0]

    if count > 1
      store[0] = store.pop
      self.class.heapify_down(store, 0, &prc)
    else
      store.pop
    end

    val
  end

  def peek
    rails 'no element to peek' if count == 0
    store[0]
  end

  def push(val)
    store << val
    self.class.heapify_up(store, self.count - 1, &prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    [2 * parent_index + 1, 2 * parent_index + 2].select { |idx| idx < len }
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    l_ch_idx, r_ch_idx = child_indices(len, parent_idx)
    parent_val = array[parent_idx]
    children = []
    children << array[l_ch_idx] if l_ch_idx
    children << array[r_ch_idx] if r_ch_idx

    return array if children.all? { |child| prc.call(parent_val, child) <= 0 }

    swap_idx = nil

    if children.length == 1
      swap_idx = l_ch_idx
    else
      swap_idx =
        prc.call(children[0], children[1]) == -1 ? l_ch_idx : r_ch_idx
    end

    array[parent_idx], array[swap_idx] = array[swap_idx], parent_val
    heapify_down(array, swap_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if child_idx == 0

    parent_idx = parent_index(child_idx)
    ch_val, p_val = array[child_idx], array[parent_idx]

    if prc.call(ch_val, p_val) >= 0
      return array
    else
      array[child_idx], array[parent_idx] = p_val, ch_val
      heapify_up(array, parent_idx, len, &prc)
    end
  end
end
