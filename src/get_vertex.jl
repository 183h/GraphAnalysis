#=
Popis
  Funkcia navrati datovu strukturu vrchola zo zadaneho grafu na zaklade jeho indexu.

Parametre
  index : parameter udavajuci index vrchola :: Int64
  g : datova struktura grafu :: GenericGraph

Navratova hodnota
  vert : datova struktura vrchola :: ExVertex

Poznamky
  V pripade ak sa dany vrchol v grafe nenachadza, navratova hodnoa funkcie je false(::Bool).
=#

function get_vertex(index::Int64, g::GenericGraph)

  for vert in vertices(g)
    if vert.index == index
      return vert
    end
  end

  return false

end
