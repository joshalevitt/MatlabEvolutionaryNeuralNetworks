function [ score ] = CheckFitness( NN, Policy, seed )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

rng(round(seed)*100000);

numAsteroid=1;
[X,Y,H,Si,Speed,~]=initAsteroid(rand);
asterX=X;
asterY=Y;
asterHeading=H;
asterSize=Si;
asterSpeed=Speed;

RunnerX=10;
RunnerY=10;
RunnerHeading=0;
RunnerSpeed=0;
maxSpeed=0.4;

StepSize=0.1;
alive=1;
numSteps=10000;
difficulty=0.03;
totalSpeed=0;
turns=0;
accels=0;
turn=0;
step=1;
while alive==1&&step<100000;
    astercount=1;
    while astercount<=length(asterX)
        asterX(astercount)=asterX(astercount)+asterSpeed(astercount)*sin(asterHeading(astercount));
        asterY(astercount)=asterY(astercount)+asterSpeed(astercount)*cos(asterHeading(astercount));

        if asterIsAlive(asterX(astercount),asterY(astercount),asterSize(astercount))==0
            asterX(astercount)=[];
            asterY(astercount)=[];
            asterSize(astercount)=[];
            asterSpeed(astercount)=[];
            asterHeading(astercount)=[];
            astercount=astercount-1;
            numAsteroid=numAsteroid-1;
        end
        astercount=astercount+1;
    end
    if rand<difficulty
        numAsteroid=numAsteroid+1;
        [X,Y,H,Si,Speed,~]=initAsteroid(rand);
        asterX(numAsteroid)=X;
        asterY(numAsteroid)=Y;
        asterHeading(numAsteroid)=H;
        asterSize(numAsteroid)=Si;
        asterSpeed(numAsteroid)=Speed;
    end
    [Left,FLeft,Front,FRight,Right,BRight,Back,BLeft]=GetDistances(RunnerX,RunnerY,RunnerHeading,asterX,asterY,asterSize);
    features=[Left,FLeft,Front,FRight,Right,BRight,Back,BLeft,turn,RunnerSpeed];
    [L,R,F,B,Layer1Activ]=ForwardProp(features,Policy,NN);
    accel=(F-B)/2.5;
    turn=pi*.1*(R-L);
    turns(step)=turn;
    accels(step)=accel;
    
    RunnerHeading=RunnerHeading+turn;
    RunnerSpeed=accel;
    totalSpeed=totalSpeed+RunnerSpeed;
    if RunnerSpeed<0*maxSpeed/10
        RunnerSpeed=0*maxSpeed/10;
    elseif RunnerSpeed>maxSpeed
        RunnerSpeed=maxSpeed;
    end
    
    RunnerX=RunnerX+sin(RunnerHeading)*RunnerSpeed;
    RunnerY=RunnerY+cos(RunnerHeading)*RunnerSpeed;
    
    alive=isAlive(RunnerX,RunnerY,asterX,asterY,asterSize);

    step=step+1;
    
    if mod(step,100)==0
        difficulty=difficulty+0.002;
    end
end

%score=step*std(turns)*std(accels);
score=step;
end

