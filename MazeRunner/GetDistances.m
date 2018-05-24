function [ Left,FLeft,Front,FRight,Right ] = GetDistances( M,X,Y,RunnerHeading )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
StepSize=.1;
%%Check Left
steps=0;
LeftHeading=RunnerHeading-90;
alive=1;
while alive==1
    checkX=X+sin(degtorad(LeftHeading))*steps*StepSize;
    checkY=Y+cos(degtorad(LeftHeading))*steps*StepSize;
    alive=isAlive(M,checkX,checkY);
    if alive==1
        steps=steps+1;
    end
end
Left=steps;   

%%Check FLeft
steps=0;
FLeftHeading=RunnerHeading-45;
alive=1;
while alive==1
    checkX=X+sin(degtorad(FLeftHeading))*steps*StepSize;
    checkY=Y+cos(degtorad(FLeftHeading))*steps*StepSize;
    alive=isAlive(M,checkX,checkY);
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
    checkX=X+sin(degtorad(FrontHeading))*steps*StepSize;
    checkY=Y+cos(degtorad(FrontHeading))*steps*StepSize;
    alive=isAlive(M,checkX,checkY);
    if alive==1
        steps=steps+1;
    end
end
Front=steps; 

%%Check Front
steps=0;
FRightHeading=RunnerHeading+45;
alive=1;
while alive==1
    checkX=X+sin(degtorad(FRightHeading))*steps*StepSize;
    checkY=Y+cos(degtorad(FRightHeading))*steps*StepSize;
    alive=isAlive(M,checkX,checkY);
    if alive==1
        steps=steps+1;
    end
end
FRight=steps;

%%Check Right
steps=0;
RightHeading=RunnerHeading+90;
alive=1;
while alive==1
    checkX=X+sin(degtorad(RightHeading))*steps*StepSize;
    checkY=Y+cos(degtorad(RightHeading))*steps*StepSize;
    alive=isAlive(M,checkX,checkY);
    if alive==1
        steps=steps+1;
    end
end
Right=steps;

end

