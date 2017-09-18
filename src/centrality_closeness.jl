#=
Popis
  Funkcia vypocita pre kazdy vrchol hodnotu jeho closeness centrality.

Parametre
  g : datova struktura grafu :: GenericGraph
  dist_key : nazov atributu, v ktorom je ulozena vlastnost vrchola :: String
  normalize : parameter pre aplikovanie normalizacie :: Bool

Navratova hodnota
  closeness : slovnik obsahujuci mapovanie vrcholov a k nim prisluchajucich hodnot
           closeness centrality (index_vrchola => hodnota_closeness_centrality) :: Dict{Int64, Float64}()

Poznamky
  Hodnota centrality moze byt normalizovana nastavenim parametra normalize na True/False.
  Vypocet centrality je upraveny aby velkost grafu neovplyvnovala hodnotu centrality.
=#

function centrality_closeness(g::GenericGraph; dist_key::AbstractString="weight", normalize::Bool=true)

  epi = AttributeEdgePropertyInspector{Float64}(dist_key)
  closeness = Dict{Int64, Float64}()

  for v in Graphs.vertices(g)
      
      distances = filter(x -> x != Inf, dijkstra_shortest_paths(g, epi, [v]).dists)
      total_dist = sum(distances)

      if total_dist > 0 && num_vertices(g) > 1

        closeness[v.index] = (length(distances) - 1.0) / total_dist

        if normalize

          norm_coefficient = (length(distances)-1.0) / ( num_vertices(g) - 1 )
          closeness[v.index] *= norm_coefficient

        end

      end

  end

  return closeness

end
