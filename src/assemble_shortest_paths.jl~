function assemble_shortest_paths(g::GenericGraph, s, dist_key; distance::Bool=false)

    nodes = [k.index => k for k = vertices(g)]

    Source_nodes = Int64[]
    Predecessors = [k.index => Int64[] for k = vertices(g)] # vymenene {} za []
    sigma = [vertex.index => 0.0 for vertex = vertices(g)]
    Distances = Dict{Int64, Float64}()
    sigma[s] = 1.0
    visited = Dict(s => 0)
    c = 0
    Q = (Array{Any, 1})[]
    Collections.heappush!(Q, [0, c += 1 , s, s],Base.Order.ord((x,y)->isless(x[1], y[1]), identity, false))

    while length(Q) > 0
        
        heap_element = Collections.heappop!(Q, Base.Order.ord((x,y)->isless(x[1], y[1]), identity, false))
        dist, _, pred, vertex = heap_element[1] , heap_element[2] , heap_element[3] , heap_element[4]

        if haskey(Distances, vertex)
            continue
        end

        sigma[vertex] += sigma[pred]
        push!(Source_nodes,vertex)
        Distances[vertex] = dist

        for edge in out_edges(nodes[vertex], g)

            vw_dist = dist + edge.attributes[dist_key]

            if (haskey(Distances, edge.target.index) == false) && ( haskey(visited, edge.target.index) == false || vw_dist < visited[edge.target.index] )

                visited[edge.target.index] = vw_dist
                Collections.heappush!(Q, [vw_dist, c += 1, vertex, edge.target.index],Base.Order.ord((x,y)->isless(x[1], y[1]), identity, false))
                sigma[edge.target.index] = 0.0
                Predecessors[edge.target.index] = [vertex]

            elseif vw_dist == visited[edge.target.index]

                sigma[edge.target.index] += sigma[vertex]
                push!(Predecessors[edge.target.index],vertex)

            end

        end

    end

    if distance
      return Source_nodes, Predecessors, Distances
    elseif !(distance)
      return Source_nodes, Predecessors, sigma
    end

end
