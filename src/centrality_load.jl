#=
Popis
  Funkcia vypocita pre kazdy vrchol hodnotu jeho load centrality.

Parametre
  g : datova struktura grafu :: GenericGraph
  dist_key : nazov atributu, v ktorom je ulozena vlastnost vrchola :: String
  normalize : parameter pre aplikovanie normalizacie :: Bool

Navratova hodnota
  loadness : slovnik obsahujuci mapovanie vrcholov a k nim prisluchajucich hodnot
           closeness centrality (index_vrchola => hodnota_loadness_centrality) :: Dict{Int64, Float64}()

Poznamky
  Hodnota centrality moze byt normalizovana nastavenim parametra normalize na True/False.
=#

function centrality_load(g::GenericGraph; normalize::Bool=true, dist_key::AbstractString="weight")

  loadness = [v.index => 0.0 for v=vertices(g)]

  for s in keys(loadness)

    u_loadness = node_loadness(g, s, dist_key)

    for temp in keys(u_loadness)
      loadness[temp] += u_loadness[temp]
    end

  end

  if normalize

    vertex_count = num_vertices(g)

    if vertex_count <= 2
      return loadness
    end

    scale = 1.0 / ((vertex_count - 1) * (vertex_count - 2))

    for v in keys(loadness)
      loadness[v] *= scale
    end

  end

  return loadness

end
