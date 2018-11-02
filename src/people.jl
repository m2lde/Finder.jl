mutable struct People
    name::String
    coord::LLA
    work::String
    available::Bool
    People(n::String, c::LLA, p::String,a::Bool) = new(n,c,p,a)
    People(n::String, lat::Float64, lon::Float64, p::String,a::Bool) = new(n,lat, lon,p,a)
end


function distance(p1::People, p2::People)
    return distance(p1.coord, p2.coord)
end

function ==(p1::People, p2::People) :: Bool
    return p1.name == p2.name        &&
    p1.coord == p2.coord             &&
    p1.work == p2.work               &&
    p1.available == p2.available
end
