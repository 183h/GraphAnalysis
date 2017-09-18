#=
Popis
  Funkcia zisti vyskyt sluciek v grafe.

Parametre
  g : datova struktura grafu :: GenericGraph

Navratova hodnota
  : parameter reprezentujuci najdenie slucky(True=najdena/False=nenajdena) :: Bool

Poznamky
  Pri najdeni prvej slucky v grafe je vykonavanie funkcie ukoncene.
=#

function contains_selfloops(g::GenericGraph)

  for e in edges(g)
    if e.source == e.target
      return true
    end
  end

  return false

end
