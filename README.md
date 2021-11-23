# WaveSandcastleCellularAutomata
A wave Sandcastle Cellular Automata for MCM/ICM 2020 B. We were delighted by team 2007698's paper and codes, which introduced their CA(Cellular Automata) model. We made a new CA rule and drew a different conclusion finally.

Run begin.m to go on experiments.

## Cellular Automata rule

![](http://latex.codecogs.com/svg.latex?h_w=\\begin{cases}max\\{w_wh(sin(\\frac{2\\pi}{d}i)+\\frac{sin(\\frac{\\pi}{d}i)}{1.8}),1\\},(4k+1)d<i<(4k+2)d,k=0,1,2,...\\\\0,else\\\\\\end{cases})
Where,    
$w_w$ is the weight of wave (a given parameter),    
![](http://latex.codecogs.com/svg.latex?w_w) is the height of sandcastle,    
![](http://latex.codecogs.com/svg.latex?d) is the width of sandcastle,     
![](http://latex.codecogs.com/svg.latex?i) is the time step of CA model.
