#=
Popis
  Funkcia vytvori histogram zaznamenavajuci pocetnost stupna vrcholov v grafe.
 
Parametre
  g : datova struktura grafu :: GenericGraph

Navratova hodnota
  histogram : slovnik s mapovanim kluc=stupen_vrchola => hodnota=pocetnost_vrcholov :: Dict{Int64, Int64}()

Poznamky
=#

function degree_histogram(g::GenericGraph)

  histogram = [out_degree(v, g) => 0 for v = vertices(g)]

  for v in vertices(g)
    histogram[out_degree(v, g)] += 1
  end

  return histogram

end
