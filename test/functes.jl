using Geoo, DataStructures, Finder

curitiba = Coordinate("-25.44777778, -49.23055556")
caucuta = Coordinate("22.55694444, 88.33666667")
brasilia = Coordinate("-15.871329,-47.912457")
novayork = Coordinate("43.121948,-77.668278")

p1 = People("p1", curitiba, "trab1", true)
p2 = People("p2", caucuta, "trab2", true)
p3 = People("p3", brasilia, "trab3", true)
p4 = People("p4", novayork, "trab4", true)
D = SortedDict{Int, People}()
P = [p1 p2 p3 p4]
cc = 0

for p in P
    push!(D, cc => p)
    global cc += 1
end


function dictweightcoordinate(D)
    return  function weightcoordinate(s,t)
        return coordist(D[s].coord, D[t].coord)
    end
end
