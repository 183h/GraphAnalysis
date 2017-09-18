function assemble_endpoints(betweenness, S, P, sigma, s)

    betweenness[s] += length(S) - 1
    source_ration = [k => 0.0 for k = S]

    while length(S) > 0

        node = pop!(S)
        coeff = (1.0 + source_ration[node]) / sigma[node]

        for v in P[node]

            source_ration[v] += sigma[v] * coeff

        end

        if node != s
	
            betweenness[node] += source_ration[node] + 1

        end

    end

    return betweenness

end
