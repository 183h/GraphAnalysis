#=
Popis
  Funkcia zisti ci graf obsahuje paralelne hrany.

Parametre
  g : datova struktura grafu :: GenericGraph

Navratova hodnota
  : parameter reprezentujuci najdenie paralelnej hrany(True=najdena/False=nenajdena) :: Bool

Poznamky
  Funkcia prejde cez vsetky hrany grafu a zisti, ci sa v nom nachadzaju
  paralelne hrany. Funkcia je ukoncena ihned ako najde prvy vyskyt paralelnosti hran pricom
  vrati hodnotu True. Ak paralelne hrany neboli najdene navratova hodnota je False.
=#

function contains_parallel_edges(g::GenericGraph)

  parallel_check = Dict{Int64, Array{Tuple{Int64, Int64},1}}()
  parallel_check = [v.index => Tuple{Int64, Int64}[] for v=vertices(g)]

  for e in edges(g)

    if in((target(e).index, source(e).index), parallel_check[target(e).index]) ||
       in((source(e).index, target(e).index), parallel_check[source(e).index])

      return true

    else

      push!(parallel_check[source(e).index], (source(e).index, target(e).index))

    end

  end

  return false

end
