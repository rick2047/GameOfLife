A simple implementation of Game of Life in julia.
# Usage
    using GameOfLife
    w = world(256,256)
    wSim = simulate(w, 1000)
    GameOfLife.animate(wSim) # this will save to test.gif

# TODO
[ ] Add tests

[ ] improve simulation code, seems too slow (maybe distributed?)
