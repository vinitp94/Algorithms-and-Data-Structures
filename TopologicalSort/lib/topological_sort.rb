require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Kahn's

def topological_sort(vertices)
  in_edge_counts = {}
  vert_queue = []

  vertices.each do |vert|
    in_edge_counts[vert] = vert.in_edges.count
    vert_queue << vert if vert.in_edges.empty?
  end

  sorted = []

  until vert_queue.empty?
    vertex = vert_queue.shift
    sorted << vertex

    vertex.out_edges.each do |ed|
      to_vertex = ed.to_vertex

      in_edge_counts[to_vertex] -= 1
      vert_queue << to_vertex if in_edge_counts[to_vertex] == 0
    end
  end

  sorted
end

# Tarjan's

def tarjan_topological_sort(vertices)
  ordering = []
  visited = Set.new

  vertices.each do |vert|
    dfs!(vert, visited, ordering) unless visited.include?(vert)
  end

  ordering
end

def dfs!(vertex, visited, ordering)
  visited.add(vertex)

  vertex.out_edges.each do |ed|
    new_vert = ed.to_vertex
    dfs!(new_vert, visited, ordering) unless visited.include?(new_vert)
  end

  ordering.unshift(vertex)
end
