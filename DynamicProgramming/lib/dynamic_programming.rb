class DPProblems
  def initialize
    @fib_cache = { 1 => 1, 2 => 1 }
    @dist_cache = Hash.new { |hash, key| hash[key] = {} }
    @maze_cache = Hash.new { |hash, key| hash[key] = {} }
  end

  def fibonacci(n)
    res = fib_step(n)
    @fib_cache = { 1 => 1, 2 => 1 }
    res
  end

  def fib_step(n)
    return @fib_cache[n] if @fib_cache[n]
    next_fib = fib_step(n - 1) + fib_step(n - 2)
    @fib_cache[n] = next_fib
  end

  def make_change(amt, coins, coin_cache = {0 => 0})
    return coin_cache[amt] if coin_cache[amt]
    return 0.0 if amt < coins[0]

    min_change = amt
    found = false
    i = 0

    while i < coins.length && coins[i] <= amt
      num_change = 1 + make_change(amt - coins[i], coins, coin_cache)

      if num_change.is_a?(Integer)
        found = true
        min_change = num_change if num_change < min_change
      end

      i += 1
    end

    if found
      coin_cache[amt] = min_change
    else
      coin_cache[amt] = 0.0
    end
  end

  def knapsack(weights, values, capacity)
    return 0 if capacity == 0 || weights.length == 0
    res = knapsack_table(weights, values, capacity)
    res[capacity][weights.length - 1]
  end

  def knapsack_table(weights, values, capacity)
    res = []
    (0..capacity).each do |i|
      res[i] = []

      (0..weights.length - 1).each do |j|
        if i == 0
          res[i][j] = 0
        elsif j == 0
          res[i][j] = weights[0] > i ? 0 : values[0]
        else
          option1 = res[i][j - 1]
          option2 = i < weights[j] ? 0 : res[i - weights[j]][j - 1] + values[j]
          optimal = [option1, option2].max
          res[i][j] = optimal
        end
      end
    end

    res
  end

  def stair_climb(n)
    options = [[[]], [[1]], [[1, 1], [2]]]

    return options[n] if n < 3

    (3..n).each do |i|
      new_opt_set = []
      (1..3).each do |first_step|
        options[i - first_step].each do |way|
          new_opt = [first_step]
          way.each do |step|
            new_opt << step
          end
          new_opt_set << new_opt
        end
      end
      options << new_opt_set
    end

    options.last
  end

  def str_distance(str1, str2)
    res = str_step(str1, str2)
    @dist_cache = Hash.new { |hash, key| hash[key] = {} }
    res
  end

  def str_step(str1, str2)
    return @dist_cache[str1][str2] if @dist_cache[str1][str2]
    if str1 == str2
      @dist_cache[str1][str2] = 0
      return 0
    end

    if str1.nil?
      return str2.length
    elsif str2.nil?
      return str1.length
    end

    l1 = str1.length
    l2 = str2.length
    if str1[0] == str2[0]
      dist = str_step(str1[1..l1], str2[1..l2])
      @dist_cache[str1][str2] = dist
      return dist
    else
      opt1 = 1 + str_step(str1[1..l1], str2[1..l2])
      opt2 = 1 + str_step(str1, str2[1..l2])
      opt3 = 1 + str_step(str1[1..l1], str2)
      dist = [opt1, opt2, opt3].min
      @dist_cache[str1][str2] = dist
      dist
    end
  end

  def maze_escape(maze, start)
    res = maze_helper(maze, start)
    @maze_cache = Hash.new { |hash, key| hash[key] = {} }
    res
  end

  def maze_helper(maze, st)
    return @maze_cache[st[0]][st[1]] if @maze_cache[st[0]][st[1]]

    if (st[0] == 0 || st[1] == 0) || (st[0] == maze.length - 1 || st[1] == maze[0].length - 1)
      @maze_cache[st[0]][st[1]] = 1
      return 1
    end

    x = st[0]
    y = st[1]
    adj = [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]
    move_opts = []
    adj.each do |space|
      if maze[space[0]][space[1]] == ' '
        move_opts << space
      end
    end

    found = false
    best = maze.length * maze[0].length

    move_opts.each do |move|
      temp = make_temp(maze, st)
      possible_path = maze_helper(temp, move)
      if possible_path.is_a?(Fixnum) && possible_path < best
        found = true
        best = possible_path
      end
    end

    if found
      @maze_cache[st[0]][st[1]] = best + 1
      return best + 1
    else
      @maze_cache[st[0]][st[1]] = 0.0
      return 0.0
    end
  end

  def make_temp(maze, filled_pos)
    temp = []
    maze.each_with_index do |row, i|
      temp << []
      maze[i].each do |el|
        temp[i] << el
      end
    end

    temp[filled_pos[0]][filled_pos[1]] = 'x'
    temp
  end
end
