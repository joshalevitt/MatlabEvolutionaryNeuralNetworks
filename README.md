# MatlabEvolutionaryNeuralNetworks
# 
This repository is the result of some experiments I made into learning to using neural
networks, and learning about evolutionary algorithms. This repository is written in
MatLab. Please note that it is intended only for my own practice. I do not make any claims
with respect to its usefulness for any other purpose.

It contains 3 separate projects. The first is MazeRunner, in which an Evolutionary NN is
used to evolve a runner who can successfully navigate a maze. Use RunnerGeneration.m to
train the runner, and MazeViewer.m to watch the evolved runner navigate the maze. a fully
evolved runner should be able to navigate the maze indefinitely.

The second is called Asteroid field, it trains an agent to play the classic game asteroid.
As before, use RunnerGeneration.m to evolve an agent, and then AsteroidMap.m to watch its
performance. In this simulation the difficulty, as defined by the frequency of asteroid
appearance, increases over time, so performance has a built-in limit. However, fully
trained agents should be very effective at dodging asteroids.

The final project is called PredatorPrey. in this simulation, prey species are first
trained to find herbivorous food before starving, and then predator species are similarly
trained to hunt the prey.

For details on how each of these work, please contact me at joshua_levitt@alumni.brown.edu.