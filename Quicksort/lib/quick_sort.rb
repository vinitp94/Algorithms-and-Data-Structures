class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.empty?

    pivot = array.first

    left = array.select { |el| el < pivot }
    mid = array.select { |el| el == pivot }
    right = array.select { |el| el > pivot }

    sort1(left) + mid + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if length < 2

    pivot = partition(array, start, length, &prc)
    left_len = pivot - start
    right_len = length - (left_len + 1)

    sort2!(array, start, left_len, &prc)
    sort2!(array, pivot + 1, right_len, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot = start
    pivot_val = array[start]

    ((start + 1)...(start + length)).each do |i|
      if prc.call(pivot_val, array[i]) > 0
        array[i], array[pivot + 1] = array[pivot + 1], array[i]
        pivot += 1
      end
    end

    array[start], array[pivot] = array[pivot], array[start]

    pivot
  end
end
