#=
Popis
  Funkcia prepise obsah datovej struktury grafu do suboru.

Parametre
  g : datova struktura grafu :: GenericGraph
  path : absolutna cesta k suboru kam sa ulozi graf :: String
  dist_key : nazov atributu, v ktorom je ulozene ohodnotenie hrany :: String
  index : parameter pre zmenu sposobu ulozenia vrcholov :: Bool

Navratova hodnota
  Funkcia nema ziadnu navratovu hodnotu.

Poznamky
  Funkcia vytvori subor alebo ak uz v danom adresari subor
  existuje tak je jeho obsah prepisany. Parameter index umoznuje pouzivatelovi
  prepnut medzi zapisom vrcholov do suboru podla indexu alebo ich oznacenia tzv. labelu.
  Parameter dist_key oznacuje nazov atributu kde je ulozene ohodnotenie hrany.
=#

function save_graph(g::GenericGraph, path::AbstractString; dist_key::AbstractString="weight", index::Bool=true)

  edge_array = edges(g)
  vertex_array = vertices(g)
  file = nothing

  try
    file = open(path, "w")
  catch e
    println(e)
  end

  if index

    for edge in edge_array

      write(file, dec(edge.source.index), " ",
            dec(edge.target.index), " ",
            string(edge.attributes[dist_key]), "\r\n")

	  end

  else

    for edge in edge_array

      write(file, edge.source.label, " ",
            edge.target.label, " ",
            string(edge.attributes[dist_key]), "\r\n")

	  end

  end

  try
    close(file)
  catch e
    println(e)
  end

  return

end
