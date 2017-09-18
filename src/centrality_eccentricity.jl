#=
Popis
  Funkcia vypocita hodnotu eccentricity centrality pre kazdy vrchol.

Parametre
  g : datova struktura grafu :: GenericGraph
  dist_key : nazov atributu, v ktorom je ulozene ohodnotenie hrany :: String

Navratova hodnota
  eccentricity : slovnik s mapovanim (kluc=vrchol_grafu => hodnota=eccentricita) :: Dict{Int64, Float64}

Poznamky
=#

function centrality_eccentricity(g::GenericGraph; dist_key::AbstractString="weight")

  epi = AttributeEdgePropertyInspector{Float64}(dist_key)
  eccentricity = [v.index => 0.0 for v=vertices(g)]

  for v in vertices(g)

    temp_dists = dijkstra_shortest_paths(g, AttributeEdgePropertyInspector{Float64}(dist_key), [v]).dists
    temp_dists = filter(x -> x != Inf, temp_dists)
    ecc = 1.0/(maximum(temp_dists))

    if ecc != Inf
      eccentricity[v.index] = ecc
    elseif ecc == Inf
      eccentricity[v.index] = 0.0
    end

  end

  return eccentricity

end
