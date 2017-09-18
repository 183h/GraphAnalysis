#=
Popis
  Funkcia vypocita radius grafu.

Parametre
  g : datova struktura grafu :: GenericGraph
  dist_key : nazov atributu, v ktorom je ulozena vlastnost vrchola :: String
  components : parameter pre prepinanie graf/max_komponent :: Bool

Navratova hodnota
  : radius maximalneho komponentu :: Float64
  g_radius : radius grafu :: Float64

Poznamky
  Funkcia podla hodnoty parametra components vypocita hodnotu
  pre cely graf alebo pre najvacsi komponent.
=#

function graph_radius(g::GenericGraph; dist_key::AbstractString="weight", components::Bool=false)

  if components
    comp_radius = Dict{Array{ExVertex,1}, Float64}()
    comp_length = Int64[]
    
    for comp in connected_components(g)
      comp_radius[comp] = minimum([vertex_eccentricity(v.index, g) for v in comp])
      push!(comp_length, length(comp))
    end
    
    max_comp = maximum(comp_length)
        
    return [r[2] for r=filter!(x -> length(x[1]) == max_comp, collect(zip(keys(comp_radius), values(comp_radius))))]
  else
    g_radius = [vertex_eccentricity(v.index, g) for v in vertices(g)]

    return minimum(g_radius)
  end

end
