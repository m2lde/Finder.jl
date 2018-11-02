__precompile__()
"""
Finder is a module that find freelancers near
"""
module Finder

using MyGraph, Geodesy, DataStructures

import Base: ==
import Geodesy: distance

export  FinderGraph, People,
        availableworkers, availableworkersbyprof, findworkers!

include("people.jl")
include("findergraph.jl")

end
