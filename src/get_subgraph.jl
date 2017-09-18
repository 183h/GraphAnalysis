#=
Popis
  Funkcia vrati podgraf zo zadaneho grafu na zaklade indexov.

Parametre
  verts: pole indexov vrcholov ::Array{Int64, 1}
  g: datova struktura grafu :: GenericGraph

Navratova hodnota
  sub_graph: podgraf grafu g :: GenericGraph

Poznamky
  Funkcia vytvori novy podgraf zo zadaneho grafu.
=#

function get_subgraph(verts::Array{Int64, 1}, g::GenericGraph)

  sub_graph = Graphs.graph(Graphs.ExVertex[], Graphs.ExEdge{Graphs.ExVertex}[], is_directed=false)

  for v in sort(verts)
    add_vertex!(sub_graph, get_vertex(v, g))
  end

  for e in edges(g)
    if in(source(e).index, verts) && in(target(e).index, verts)

      edge_sub = add_edge!(sub_graph, get_vertex(source(e).index, g), get_vertex(target(e).index, g))

      for (att,value) in e.attributes
        edge_sub.attributes[att] = value
      end

    end
  end

  return sub_graph

end
