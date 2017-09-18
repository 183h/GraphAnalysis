#=
Popis

Parametre

Navratova hodnota

Poznamky

=#

function rescale_graph(betweenness, n, normalized, k)

  if normalized == true

    if n <= 2
      proportion = nothing
    else
      proportion = 1.0 / ((n - 1) * (n - 2))
    end

  else
    proportion = 1.0 / 2.0
  end

  if proportion != nothing

    if k != nothing
      proportion = proportion * n / k
    end

        for v in keys(betweenness)
            betweenness[v] *= proportion
        end

  end

  return betweenness

end
