function makefile(file::String, n::Int)
    nams = open("test\\names.txt") do f
        readlines(f)
    end

    works = open("test\\works.txt") do f
        readlines(f)
    end

    open(file, "w") do f
        for i = 1:n
            l::String, w::String = rand(nams), rand(works);
            lat::Float64 = -rand(15.499326:.00001:16.051805);
            lon::Float64 = -rand(47.421716:.00001:48.276477);
            avl::Bool = rand(Bool);
            write(f, l, ";","$(lat),$(lon)" ,";",w,";$(avl)\n")
        end
    end
end
