#
function dictweightcoordinate(D::AbstractDict{Int, Professional})
    return  function weightcoordinate(s,t)
        return distance(D[s], D[t])/1000
    end
end

mutable struct FinderGraph
    graph::DictGraph
    pmap::AbstractDict{Int, Professional}
    user::Pair{Int, Professional}

    #Constructor
    function FinderGraph(file::String;
                        user = Professional("usuario", LLA(-15.836073, -47.912019), "Programador",true),
                        radius = 100.0)
        #regex for indentify the pattern of the input in each line
        r = r"^(.*?);(.*?);(.*?);([Tt][Rr][Uu][Ee]|[Ff][aA][Ll][Ss][Ee])$";
        #dict of all workers availabel
        D = SortedDict{Int, Professional}(0 => user)
        #opening the file
        open(file) do data
            #read each line of the file
            for (index, line) in enumerate(eachline(data))
                #check if the line matches with r
                occursin(r, line) || error("invalid input at line $index \n-> $line");

                #split the line in ;
                cut = split(line, ";");

                #if the worker isnt availabel, jump him
                lowercase(string(cut[4])) == "false" && continue

                #read the coordinate and parse it to Float64
                lat, lon = map(x -> parse(Float64, x), split(cut[2], ","));

                #compute the distance between the user and the worker.
                #If the distance is greater than radius, jump him
                distance(LLA(lat, lon), user.coord)/1000 > radius && continue

                #parse the availabel string to bool
                avlb = parse(Bool, lowercase(string(cut[4])))

                #put that worker on the dict D
                push!(D, index => Professional(string(cut[1]), LLA(lat, lon), string(cut[2]), avlb))
            end
        end

        G = buildconnectedgraph(collect(keys(workers)); f = dictweightcoordinate(workers))
        #return a new object Finder Graph
        new(G, D, 0 => user)
    end

    function FinderGraph(D::AbstractDict{Int, Professional})
        G = buildconnectedgraph(collect(keys(D)); f = dictweightcoordinate(D))
        new(G, D, 0 => D[0])
    end
end

function makeroute(F::FinderGraph)
    return makecirclepath(F.graph;source = F.user.first, ending = F.user.first)
end
