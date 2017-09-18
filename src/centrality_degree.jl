#=
Popis
  Funkcia vypocita pre kazdy vrchol hodnotu jeho degree centrality.

Parametre
  g : datova struktura grafu :: GenericGraph

Navratova hodnota
  degree : slovnik obsahujuci mapovanie vrcholov a k nim prisluchajucich hodnot
           degree centrality (index_vrchola => hodnota_degree_centrality) :: Dict{Int64, Float64}()

Poznamky
  Hodnota centrality je normalizovana (norm_coefficient).
=#

function centrality_degree(g::GenericGraph)

  degree = Dict{Int64, Float64}()

  norm_coefficient = 1.0 / (num_vertices(g) - 1.0)

  for vertex in vertices(g)

    degree[vertex.index] = out_degree(vertex, g) * norm_coefficient

  end

  return degree

end
