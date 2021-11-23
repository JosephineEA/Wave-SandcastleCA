# WaveSandcastleCellularAutomata
A wave Sandcastle Cellular Automata for MCM/ICM 2020 B. We were delighted by team 2007698's paper and codes, which introduced their CA(Cellular Automata) model. We made a new CA rule and drew a different conclusion finally.

Run begin.m to go on experiments.

## Cellular Automata rule

![](http://latex.codecogs.com/svg.latex?h_w=\\begin{cases}max\\{w_wh(sin(\\frac{2\\pi}{d}i)+\\frac{sin(\\frac{\\pi}{d}i)}{1.8}),1\\},(4k+1)d<i<(4k+2)d,k=0,1,2,...\\\\0,else\\\\\\end{cases})    
Where,    
![](http://latex.codecogs.com/svg.latex?w_w) is the weight of wave (a given parameter),        
![](http://latex.codecogs.com/svg.latex?h) is the height of sandcastle,    
![](http://latex.codecogs.com/svg.latex?d) is the width of sandcastle,     
![](http://latex.codecogs.com/svg.latex?i) is the time step of CA model.

Our model wiil keep generating wave cells with height following this formula at each time step.

### Sandcastle
We experiment on different shape of pyramids, including triangular pyramid, quadrangular pyramid, hexagonal pyramid and circular pyramid.

Our model will generate a pyramid with sand cells and sand-water cells at the beginning of each experiment.

### Cell
We will build a 3d CA model. Like the shape of Rubik's cube, each cells are consider to be next to 26 cells. There are 4 kinds of cells in our model: sand cell, wave call, sand-water cell and rain cell. 

**Wave cells** are believed to keep a trend of moving forward. At the same time, they will also be influent by power of gravity. Each wave cell will move to a position if that position is empty following a specific priority.

**Sand cells** will be influent by power of gravity, but they will keep stable if there's no enough wave force to push them. If wave's impact force is bigger than sancastle's tack force, then the sand cell wiil be moved. the calculation of both force are based on their own formula.

**Sand-water cells** influent the water ratio in sandcastle. They share the same cell rules with sand cells, when a sand-water cell is surrounded by a number of wave cells, it will transfer to a wave cell, too.

**Rain cells** appear in each time step when having rainy experiment. It keeps falling to the ground. When it contacts with a wave cell, it will transfer to a wave cell, too.

## Conclusion
By setting proper cell rules for them, we concluded that the most stable foundation should be a quadrangular pyramid in sunny days but a circular pyramid in rainy days.
