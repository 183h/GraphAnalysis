#=
Popis
  Funkcia vypocita prislusnost kazdeho vrcholu do jadra.

Parametre
  g : datova struktura grafu :: GenericGraph

Navratova hodnota
  _coreness : slovnik obsahujuci mapovanie hodnoty prislusnosti do
                jadra pre prisluchajuci vrchol (index_vrchola => hodnota_jadra) :: Dict{Int64, Int64}()

Poznamky
  Graf nesmie obsahovat paralelne hrany a slucky.
=#

function coreness(g::GenericGraph)

    if GraphAnalysis.contains_parallel_edges(g)
      println("Graf obsahuje paralelne hrany!")
      return false
    end

    if GraphAnalysis.contains_selfloops(g)
      println("Graf obsahuje slucky!")
      return false
    end

    degrees = [v.index => out_degree(v, g) for v=vertices(g)]
    verts = [v for v=sort(collect(degrees), by = x-> (x[2],x[1]))]
    bound = [1]
    actual_degree = 0

    for (i,v) in enumerate(verts)
      if degrees[v[1]] > actual_degree
        for j = 1:(degrees[v[1]] - actual_degree)
          append!(bound,[(i)])
        end
        actual_degree = degrees[v[1]]
      end
    end

    sort!(bound)
    position = [v[1] => pos for (pos, v)=enumerate(verts)]
    _coreness = degrees
    neighbours = Dict{Int64,Array{Int64,1}}
    neighbours = [v.index => [n.index for n=out_neighbors(v,g)]  for v=vertices(g)]

    for vertex in verts
      for u in neighbours[vertex[1]]
        if _coreness[u] > _coreness[vertex[1]]
                  splice!(neighbours[u],findfirst(neighbours[u],vertex[1]))
                  pos = position[u]
                  start = bound[_coreness[u]+1]
                  position[u] = start
                  position[verts[start][1]] = pos
                  verts[start], verts[pos] = verts[pos], verts[start]
                  bound[_coreness[u]+1] += 1
                  _coreness[u] -= 1
        end
      end
    end

    return _coreness

end
