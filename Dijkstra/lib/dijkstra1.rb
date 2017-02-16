require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  locked_in_paths = {}
  possible_paths = {
    source => { cost: 0, last_edge: nil }
  }

  until possible_paths.empty?
    vert = select_possible_path(possible_paths)

    locked_in_paths[vert] = possible_paths[vert]
    possible_paths.delete(vert)

    update_possible_paths(vert, locked_in_paths, possible_paths)
  end

  locked_in_paths
end

def select_possible_path(possible_paths)
  vert, data = possible_paths.min_by do |(vert, data)|
    data[:cost]
  end

  vert
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
