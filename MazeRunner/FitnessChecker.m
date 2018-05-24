function [ step ] = FitnessChecker(Policy,Maze,NN)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
RunnerX=3.5;
RunnerY=2.5;
RunnerZ=2;

RunnerHeading=90;


StepSize=0.1;
alive=1;

step=0;
while alive==1

    [Left,FLeft,Front,FRight,Right]=GetDistances(Maze,RunnerX,RunnerY,RunnerHeading);
    Features=[Left,FLeft,Front,FRight,Right];
    [L,R]=ForwardProp(Features,Policy,NN);
    RunnerHeading=RunnerHeading+R*10;
    RunnerHeading=RunnerHeading-L*10;
    RunnerX=RunnerX+sin(degtorad(RunnerHeading))*StepSize;
    RunnerY=RunnerY+cos(degtorad(RunnerHeading))*StepSize;
    Maze(floor(RunnerY),floor(RunnerX))=Maze(floor(RunnerY),floor(RunnerX))-0.04;
    alive=isAlive(Maze,RunnerX,RunnerY);
    step=step+1;
end

end

