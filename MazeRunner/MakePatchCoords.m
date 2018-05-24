function [ X,Y,Z,C ] = MakePatchCoords(RunnerX, RunnerY, RunnerZ, RunnerHeading)

PatchSize=.5;
PatchTipX=RunnerX+sin(degtorad(RunnerHeading))*PatchSize;
PatchTipY=RunnerY+cos(degtorad(RunnerHeading))*PatchSize;
PatchBackRX=RunnerX+sin(degtorad(RunnerHeading+160))*PatchSize;
PatchBackRY=RunnerY+cos(degtorad(RunnerHeading+160))*PatchSize;
PatchBackLX=RunnerX+sin(degtorad(RunnerHeading+200))*PatchSize;
PatchBackLY=RunnerY+cos(degtorad(RunnerHeading+200))*PatchSize;

X=[PatchTipX,PatchBackRX,PatchBackLX];
Y=[PatchTipY,PatchBackRY,PatchBackLY];
Z=[RunnerZ-0.5,RunnerZ-0.5,RunnerZ-0.5];
C=[1,0,0];

end

