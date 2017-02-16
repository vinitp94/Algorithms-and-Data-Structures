require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  locked_in_paths = {}
  possible_paths = PriorityMap.new do |d1, d2|
    d1[:cost] <=> d2[:cost]
  end

  possible_paths[source] = { cost: 0, last_edge: nil }

  until possible_paths.empty?
    vert, data = possible_paths.extract
    locked_in_paths[vert] = data

    update_possible_paths(vert, locked_in_paths, possible_paths)
  end

  locked_in_paths
end

def update_possible_paths(vert, locked_in_paths, possible_paths)
  path_to_vert_cost = locked_in_paths[vert][:cost]

  vert.out_edges.each do |ed|
    to_vert = ed.to_vertex

    next if locked_in_paths.has_key?(to_vert)
    extended_path_cost = path_to_vert_cost + ed.cost
    next if possible_paths.has_key?(to_vert) && possible_paths[to_vert][:cost] <= extended_path_cost

    possible_paths[to_vert] = {
      cost: extended_path_cost,
      last_edge: ed
    }
  end
end
