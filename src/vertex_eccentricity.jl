#=
Popis
  Funkcia vypocita hodnotu ekentricity pre dany vrchol.

Parametre
  index: index vrchola :: Int64
  g: datova struktura grafu :: GenericGraph
  dist_key : nazov atributu, v ktorom je ulozena vlastnost vrchola :: String

Navratova hodnota
  vert_eccentricity: hodnota ekcentricity pre dany vrchol :: Float64

Poznamky
=#

function vertex_eccentricity(index::Int64, g::GenericGraph; dist_key::AbstractString="weight")

  epi = AttributeEdgePropertyInspector{Float64}(dist_key)

  return vert_eccentricity = maximum(filter(x -> x != Inf,dijkstra_shortest_paths(g, epi, [get_vertex(index, g)]).dists))

end
