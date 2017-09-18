#=
Popis
  Funkcia vypocita hodnotu radiality centrality pre kazdy vrchol.

Parametre
  g : datova struktura grafu :: GenericGraph
  dist_key : nazov atributu, v ktorom je ulozene ohodnotenie hrany :: String
  normalize : parameter pre aplikovanie normalizacie :: Bool

Navratova hodnota
  radiality : slovnik s mapovanim (kluc=vrchol_grafu => hodnota=radiality) :: Dict{Int64, Float64}

Poznamky
=#

function centrality_radiality(g::GenericGraph; dist_key::AbstractString="weight", normalize::Bool=true)

  dia = graph_diameter(g)
  epi = AttributeEdgePropertyInspector{Float64}(dist_key)
  radiality = [v.index => 0.0 for v=vertices(g)]
  total_dists = Float64[]
  temp_rad = Float64[]
  temp_sum = Float64[]

  if normalize

    for v in vertices(g)

      temp_dists = dijkstra_shortest_paths(g, epi, [v]).dists
      total_dists = filter(x -> x != Inf, temp_dists)

        for s in total_dists
          push!(temp_sum, dia+1-s)
        end

      temp_rad = ((sum(temp_sum) -dia -1)/(num_vertices(g) - 1))/dia
      empty!(temp_sum)
      radiality[v.index] = temp_rad

    end

  elseif !(normalize)

    for v in vertices(g)

      temp_dists = dijkstra_shortest_paths(g, epi, [v]).dists
      total_dists = filter(x -> x != Inf, temp_dists)

        for s in total_dists
          push!(temp_sum, dia+1-s)
        end

      temp_rad = (sum(temp_sum) -dia -1)/(num_vertices(g) - 1)
      empty!(temp_sum)
      radiality[v.index] = temp_rad

    end

  end

  return radiality

end
