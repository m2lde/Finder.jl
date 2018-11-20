using Finder
using Geodesy
using Person
using MyGraph

user = Professional("usuario", LLA(-15.836073, -47.912019), "Programador", true)

function listworkers(file::String = "dados.txt", works::Array = Array{String, 1}(); dist::Float64 = 100.0)
    open("test\\" * file) do f
        for (index, line) in enumerate(eachline(f))
            p = Professional(line)
            p.available || continue
            (isempty(works) && distance(user, p)/1000 <= dist) && println("[",index,"] ", p);
            (p.work in works && distance(user, p)/1000 <= dist) && println("[",index,"] ", p);
        end
    end
end

function selectworkers(sw = Int[]) :: FinderGraph
    P = Dict{Int, Professional}(0 => user)
    open("test\\dados2.txt") do f
        for (index, line) in enumerate(eachline(f))
            index in sw ? push!(P, index => Professional(line)) : continue
        end
    end
    FinderGraph(P)
end

function traceroute(F::FinderGraph)
    return makecirclepath(F.graph)
end
