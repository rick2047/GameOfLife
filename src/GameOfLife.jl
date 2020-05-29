module GameOfLife
export world
const world = BitArray{2}

export world
world(row::Int, col::Int, trueRatio::Int=15) = rand(1:100, row, col).<trueRatio

export next
function next(w::world)
    nextWorld = deepcopy(w)
    numRows = size(w,1)
    numCols = size(w,2)
    for iR = 2:numRows-1, iC = 2:numCols-1
        neighbours = w[iR-1:iR+1, iC-1:iC+1]
        currState = neighbours[2,2]
        neighbours[2,2] = false

        neighboursCount = count(neighbours)
        if currState && neighboursCount in [2,3]
            nextWorld[iR,iC] = true
        elseif !currState && neighboursCount == 3
            nextWorld[iR,iC] = true
        else
            nextWorld[iR,iC] = false
        end
    end
    return nextWorld
end

export simulate
function simulate(wInit::world, numIter=10)
    simW = Array{world}(undef, numIter)
    simW[1] = next(wInit)
    for iIter = 2:numIter
        simW[iIter] = next(simW[iIter-1])
    end
    return simW
end

using Plots
export animate
function animate(wArr::Array{world}, fps = 5, file="test.gif")
    anim = @animate for i in 1:length(wArr)
        println("Rendering frame $(i)")
        heatmap(.!wArr[i], title="Iteration = $(i)")
    end
    gif(anim, file)
    return anim
end

end # module'
