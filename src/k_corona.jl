#=
Popis
  Funkcia vrati podgraf s vrcholmi ktore patria do k_corona.

Parametre
  g : datova struktura grafu :: GenericGraph
  k : stupen k_corona :: Int64
  core_numbers : slovnik obsahujuci indexy vrcholov a ich hodnotu jadra :: Dict{Int64,Int64}()

Navratova hodnota
  : k_corona podgraf vstupneho grafu :: GenericGraph

Poznamky
  Hodnota core_numbers je volitelna, ak nieje zadana tak prislusnost jednotlivych vrcholov
  do jadier je vypocitana funkciou coreness() zo vstupneho grafu.

  K_corona je podgraf, ktory obsahuje vrcholy z k_core, ktore maju presne k susedov.
=#

function k_corona(g::GenericGraph, k::Int64; core_numbers::Dict{Int64,Int64}=Dict{Int64,Int64}())

  if core_numbers == Dict{Int64,Int64}()
    core_numbers=coreness(g)
  end

  verts = Int64[]

  for (key,value) in core_numbers
    if value == k
      if count(x -> core_numbers[x.index] >= k, out_neighbors(get_vertex(key, g), g)) == k
        push!(verts, key)
      end
    end
  end

  return get_subgraph(verts, g)

end
