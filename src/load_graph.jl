#=
Popis
  Funkcia nacita obsah suboru a ulozi ho do datovej struktury grafu.

Parametre
  path : absolutna cesta k suboru kam sa ulozi graf :: String
  dist_key : nazov atributu, v ktorom je ulozene ohodnotenie hrany :: String
  index : parameter pre zmenu sposobu nacitania vrcholov :: Bool
  parallel : parameter pre povolenie alebo zakazanie nacitania paralelnych hran :: Bool
  selfloops : parameter pre povolenie alebo zakazanie nacitania sluciek :: Bool

Navratova hodnota
  g : datova struktura grafu, kde je ulozeny nacitany graf :: GenericGraph

Poznamky
  Funkcia nacita zo suboru riadky v tvare "zdrojovy_vrchol cielovy_vrchol cena_prechodu" a
  nasledne ich ulozi do datovej struktury grafu. Parameter index umoznuje pouzivatelovi prepnut,
  ci ma funkcia brat zapis vrchola v subore ako jeho index alebo ako oznacenie tzv. label.
  Parametrom dist_key moze pouzivatel nastavit nazov atributu, kde je ulozene ohodnotenie hrany.
  Parametrami parallel, selfloops sa povoluje/zakazuje nacitanie paralelnych hran alebo sluciek (Hodnota False
  znamena ze dany typ hrany nebude nacitany).
=#

function load_graph(path::AbstractString; dist_key::AbstractString="weight", index::Bool=true, parallel::Bool=false, selfloops::Bool=false)

  if index

    vertices_array =  DataStructures.OrderedDict{Int64, Graphs.ExVertex}()
    if !(parallel)
      parallel_check = Dict{Int64, Array{Tuple{Int64, Int64},1}}()
    end

  else

    vertices_array =  DataStructures.OrderedDict{AbstractString, Graphs.ExVertex}()
    if !(parallel)
      parallel_check = Dict{AbstractString, Array{Tuple{AbstractString, AbstractString},1}}()
    end

  end

  if index
    file = nothing
    data = Any[0,3]
    try
      file = open(path)
      data = readdlm(file, Float64)
      close(file)
    catch e
      println(e)
    end
  else
    file = nothing
    data = Any[0,3]
    try
      file = open(path)
      data = readdlm(file, AbstractString)
      close(file)
    catch e
      println(e)
    end
  end

  if index

    for v in sort(round(Int64 ,unique(vcat(data[1:end, 1], data[1:end, 2]))))
      vertices_array[v] = Graphs.ExVertex(v, string(v))

      if !(parallel)
        parallel_check[v] = []
      end
    end

  else

    index_count = 1

    for v in sort(unique(vcat(data[1:end, 1], data[1:end, 2])))
      vertices_array[string(v)] = Graphs.ExVertex(index_count, string(v))

      if !(parallel)
        parallel_check[string(v)] = []
      end

      index_count += 1
    end

  end

  g = Graphs.graph(collect(values(vertices_array)), Graphs.ExEdge{Graphs.ExVertex}[], is_directed=false)

  for i = 1:size(data)[1]

    if parallel==true && selfloops==true

      Graphs.add_edge!(g, vertices_array[index ? Int(data[i, 1]) : string(data[i, 1])],
                       vertices_array[index ? Int(data[i, 2]) : string(data[i, 2])]).attributes[dist_key]= float(data[i, 3])

    elseif parallel==true && selfloops==false

      if (index ? Int(data[i, 1]) : string(data[i, 1])) != (index ? Int(data[i, 2]) : string(data[i, 2]))
        Graphs.add_edge!(g, vertices_array[index ? Int(data[i, 1]) : string(data[i, 1])],
                         vertices_array[index ? Int(data[i, 2]) : string(data[i, 2])]).attributes[dist_key]= float(data[i, 3])
      end

    elseif parallel==false && selfloops==true

      if !(in((index ? Int(data[i, 2]) : string(data[i, 2]), index ? Int(data[i, 1]) : string(data[i, 1])),
         parallel_check[index ? Int(data[i, 2]) : string(data[i, 2])])) && !(in((index ? Int(data[i, 1]) : string(data[i, 1]),
         index ? Int(data[i, 2]) : string(data[i, 2])), parallel_check[index ? Int(data[i, 1]) : string(data[i, 1])]))

        Graphs.add_edge!(g, vertices_array[index ? Int(data[i, 1]) : string(data[i, 1])],
                        vertices_array[index ? Int(data[i, 2]) : string(data[i, 2])]).attributes[dist_key]= float(data[i, 3])
        push!(parallel_check[index ? Int(data[i, 1]) : string(data[i, 1])], (index ? Int(data[i, 1]) : string(data[i, 1]), index ? Int(data[i, 2]) : string(data[i, 2])))
      
      end

    elseif parallel==false && selfloops==false
      
      if (index ? Int(data[i, 1]) : string(data[i, 1])) != (index ? Int(data[i, 2]) : string(data[i, 2]))
        
        if !(in((index ? Int(data[i, 2]) : string(data[i, 2]), index ? Int(data[i, 1]) : string(data[i, 1])),
           parallel_check[index ? Int(data[i, 2]) : string(data[i, 2])])) && !(in((index ? Int(data[i, 1]) : string(data[i, 1]),
           index ? Int(data[i, 2]) : string(data[i, 2])), parallel_check[index ? Int(data[i, 1]) : string(data[i, 1])]))

        Graphs.add_edge!(g, vertices_array[index ? Int(data[i, 1]) : string(data[i, 1])],
        vertices_array[index ? Int(data[i, 2]) : string(data[i, 2])]).attributes[dist_key]= float(data[i, 3])
        
        push!(parallel_check[index ? Int(data[i, 1]) : string(data[i, 1])], (index ? Int(data[i, 1]) : string(data[i, 1]), index ? Int(data[i, 2]) : string(data[i, 2])))

        end

      end

    end

  end

  return g

end
