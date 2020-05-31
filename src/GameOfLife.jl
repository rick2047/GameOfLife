module GameOfLife

## types and constructors
export world
const world = BitArray{2}

export world
world(row::Int, col::Int, trueRatio::Int=10) = rand(1:100, row, col).<trueRatio

## simulation

# single iteration
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

using Makie
# a full simulation
export simulate
function simulate(;wInit::world=world(256,256), numIter::Int=10, visualize::Bool=false)
    # make an array to hold each iteration
    simW = Array{world}(undef, numIter)
    simW[1] = next(wInit)
    if visualize
        scene, wNode = draw(simW[1]);
    end
    for iIter = 2:numIter
        simW[iIter] = next(simW[iIter-1])
        if visualize
            wNode[] = simW[iIter]
            display(scene)
            sleep(0.1)
        end
    end
    return simW, scene
end

export draw
function draw(w::world)
    s = Scene();
    wNode = Node(w);
    wFrame = @lift(.!$wNode)
    heatmap!(wFrame,colormap=:grays)
    return s, wNode
end

end # module
