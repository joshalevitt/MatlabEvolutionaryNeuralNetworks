function [ X,Y,C ] = MakePatchCoords(RunnerX, RunnerY, RunnerHeading)

PatchSize=.5;
PatchTipX=RunnerX+sin(RunnerHeading)*PatchSize;
PatchTipY=RunnerY+cos(RunnerHeading)*PatchSize;
PatchBackRX=RunnerX+sin(RunnerHeading+(pi/1.2))*PatchSize;
PatchBackRY=RunnerY+cos(RunnerHeading+(pi/1.2))*PatchSize;
PatchBackLX=RunnerX+sin(RunnerHeading-(pi/1.2))*PatchSize;
PatchBackLY=RunnerY+cos(RunnerHeading-(pi/1.2))*PatchSize;

X=[PatchTipX,PatchBackRX,PatchBackLX];
Y=[PatchTipY,PatchBackRY,PatchBackLY];

C=[1,0,0];

end

