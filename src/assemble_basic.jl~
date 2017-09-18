function assemble_basic(betweenness, S, P, sigma, s)

    source_ration = [k => 0.0 for k = S]

    while length(S) > 0

        node = pop!(S)
        ration = (1.0 + source_ration[node]) / sigma[node]

        for v in P[node]

            source_ration[v] += sigma[v] * ration

        end

        if node != s

            betweenness[node] += source_ration[node]

        end

    end

    return betweenness

end
