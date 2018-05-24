function [ Left,FLeft,Front,FRight,Right,BRight,Back,BLeft ] = GetDistances(X,Y,RunnerHeading,asterX,asterY,asterSize )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
StepSize=1;
%%Check Left
steps=0;
LeftHeading=RunnerHeading-(pi/2);
alive=1;
while alive==1
    checkX=X+sin(LeftHeading)*steps*StepSize;
    checkY=Y+cos(LeftHeading)*steps*StepSize;
    alive=isAlive(checkX,checkY,asterX,asterY,asterSize);
    if alive==1
        steps=steps+1;
    end
end
Left=steps;   

%%Check FLeft
steps=0;
FLeftHeading=RunnerHeading-(pi/4);
alive=1;
while alive==1
    checkX=X+sin(FLeftHeading)*steps*StepSize;
    checkY=Y+cos(FLeftHeading)*steps*StepSize;
    alive=isAlive(checkX,checkY,asterX,asterY,asterSize);
    if alive==1
        steps=steps+1;
    end
end
FLeft=steps; 

%%Check Front
steps=0;
FrontHeading=RunnerHeading;
alive=1;
while alive==1
    checkX=X+sin(FrontHeading)*steps*StepSize;
    checkY=Y+cos(FrontHeading)*steps*StepSize;
    alive=isAlive(checkX,checkY,asterX,asterY,asterSize);
    if alive==1
        steps=steps+1;
    end
end
Front=steps; 

%%Check Front
steps=0;
FRightHeading=RunnerHeading+pi/4;
alive=1;
while alive==1
    checkX=X+sin(FRightHeading)*steps*StepSize;
    checkY=Y+cos(FRightHeading)*steps*StepSize;
    alive=isAlive(checkX,checkY,asterX,asterY,asterSize);
    if alive==1
        steps=steps+1;
    end
end
FRight=steps;

%%Check Right
steps=0;
RightHeading=RunnerHeading+pi/2;
alive=1;
while alive==1
    checkX=X+sin(RightHeading)*steps*StepSize;
    checkY=Y+cos(RightHeading)*steps*StepSize;
    alive=isAlive(checkX,checkY,asterX,asterY,asterSize);
    if alive==1
        steps=steps+1;
    end
end
Right=steps;

%%Check BRight
steps=0;
RightHeading=RunnerHeading+pi/2+pi/4;
alive=1;
while alive==1
    checkX=X+sin(RightHeading)*steps*StepSize;
    checkY=Y+cos(RightHeading)*steps*StepSize;
    alive=isAlive(checkX,checkY,asterX,asterY,asterSize);
    if alive==1
        steps=steps+1;
    end
end
BRight=steps;

%%Check Back
steps=0;
RightHeading=RunnerHeading+pi;
alive=1;
while alive==1
    checkX=X+sin(RightHeading)*steps*StepSize;
    checkY=Y+cos(RightHeading)*steps*StepSize;
    alive=isAlive(checkX,checkY,asterX,asterY,asterSize);
    if alive==1
        steps=steps+1;
    end
end
Back=steps;

%%Check BRight
steps=0;
RightHeading=RunnerHeading-pi/2-pi/4;
alive=1;
while alive==1
    checkX=X+sin(RightHeading)*steps*StepSize;
    checkY=Y+cos(RightHeading)*steps*StepSize;
    alive=isAlive(checkX,checkY,asterX,asterY,asterSize);
    if alive==1
        steps=steps+1;
    end
end
BLeft=steps;
end

