struct MatrixRange{T<:Integer, S<:String} 
    hands::Vector{S}
    numberofhands::Vector{T}
    idxhands::Vector{Tuple{T,T}}
    fullrange::Matrix{T}
end

function getmatrixrange(filename)
    data = readdlm(filename, ',', String; skipstart=2)

    hands = get.(Ref(RANGENUMBERS), data[:, 1], 0)
    numberofhands = parse.(Int, data[:,2])
    
    defaultmatrix = zeros(Int, 13, 13);
    for (idx, nhands) in zip(hands, numberofhands)
        defaultmatrix[idx...] = nhands
    end

    MatrixRange(data[:,1], numberofhands, hands, defaultmatrix)
end

function plotrange(filename::String; titleplot::String= "")
    
    pokerrange = getmatrixrange(filename);

    f = Figure()
    
    ax = Axis(f[1, 1], 
        title=(titleplot == "") ? filename : titleplot, 
        # title="Open-Raise BU (NL5)", 
        titlecolor=:black, 
        titlesize=18
    )
    hidedecorations!(ax, minorgrid=false, grid=false, ticks=false)
    
    maxhands = maximum(pokerrange.fullrange)
    stepsize = floor(maxhands/10)

    hm = heatmap!(ax,
        reverse(rotl90(pokerrange.fullrange)),
        levels=0:stepsize:maxhands,
        colormap=:Reds,
        # colormap = range(colorant"skyblue2", stop=colorant"firebrick", length=10),
        lowclip=:white,
        interpolate=false
    )
    Colorbar(
        f[1, 2], hm, 
        ticks=0:stepsize:maxhands,
        labelpadding=1
    )

    text!(
        vec(rotr90(reshape(collect(values(RANGENUMBERS)), 13, 13))),
        text=vec(reverse(reshape(collect(keys(RANGENUMBERS)), 13, 13))),
        align=(:center, :center),
        # color=(:white, 1)
        color=(:black, 0.9)
    )

    f
end
