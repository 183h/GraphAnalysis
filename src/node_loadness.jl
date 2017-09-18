function node_loadness(g::GenericGraph, index::Int64, dist_key::AbstractString)

  S, P, D = GraphAnalysis.assemble_shortest_paths(g, index, dist_key, distance=true)

  sorted_nodes = Int64[]
  sorted_temp = sort(collect(zip(values(D), keys(D))))

  for temp in sorted_temp
    if temp[1] > 0.0 && temp[1] != Inf
      push!(sorted_nodes, temp[2])
    end
  end

  load = [ k => 1.0 for k=keys(D)]

  while length(sorted_nodes) > 0

    v = pop!(sorted_nodes)

    if haskey(P, v)
      paths_count = length(P[v])

      for x in P[v]

        if x == index
          break
        end

        load[x] += load[v] / float(paths_count)
      end

    end

  end

  for v in keys(load)
    load[v] -= 1
  end

  return load

end
