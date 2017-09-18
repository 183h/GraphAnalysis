#=
Popis
  Funkcia vypocita diameter grafu.

Parametre
  g : datova struktura grafu :: GenericGraph
  dist_key : nazov atributu, v ktorom je ulozena vlastnost vrchola :: String
  components : parameter pre prepinanie graf/max_komponent :: Bool

Navratova hodnota
  : diameter maximalneho komponentu :: Float64
  g_diameter : diameter grafu :: Float64

Poznamky
  Funkcia podla hodnoty parametra components vypocita hodnotu
  pre cely graf alebo pre najvacsi komponent.
=#

function graph_diameter(g::GenericGraph; dist_key::AbstractString="weight", components::Bool=false)

  if components
    comp_diameter = Dict{Array{ExVertex,1}, Float64}()
    comp_length = Int64[]

    for comp in connected_components(g)
      comp_diameter[comp] = maximum([vertex_eccentricity(v.index, g) for v in comp])
      push!(comp_length, length(comp))
    end
    
    max_comp = maximum(comp_length)
        
    return [d[2] for d=filter!(x -> length(x[1]) == max_comp, collect(zip(keys(comp_diameter), values(comp_diameter))))]
  else
    g_diameter = [vertex_eccentricity(v.index, g) for v in vertices(g)]

    return maximum(g_diameter)
  end

end

