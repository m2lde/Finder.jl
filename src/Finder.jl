__precompile__()

"""
Finder is a module that find freelancers near
"""
module Finder

using MyGraph, Person, DataStructures, Geodesy

export  FinderGraph, Person,
        availableworkers, availableworkersbyprof, findworkers!

include("findergraph.jl")

end
