function [ F,B,L,R ] = GetFoodDistances( RunnerX,RunnerY,RunnerHeading,FoodX,FoodY,FoodSize )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
stepSize=0.2;
numFood=length(FoodX);
checkX=RunnerX+stepSize*sin(RunnerHeading);
checkY=RunnerY+stepSize*cos(RunnerHeading);
F=0;
food=1;
while food<=numFood
    F=F+FoodSize(food)*(1/norm([checkX-FoodX(food),checkY-FoodY(food)])^2);
    food=food+1;
end

checkX=RunnerX+stepSize*sin(RunnerHeading+pi/2);
checkY=RunnerY+stepSize*cos(RunnerHeading+pi/2);
R=0;
food=1;
while food<=numFood
    R=R+FoodSize(food)*(1/norm([checkX-FoodX(food),checkY-FoodY(food)])^2);
    food=food+1;
end

checkX=RunnerX+stepSize*sin(RunnerHeading+pi);
checkY=RunnerY+stepSize*cos(RunnerHeading+pi);
B=0;
food=1;
while food<=numFood
    B=B+FoodSize(food)*(1/norm([checkX-FoodX(food),checkY-FoodY(food)])^2);
    food=food+1;
end

checkX=RunnerX+stepSize*sin(RunnerHeading-pi/2);
checkY=RunnerY+stepSize*cos(RunnerHeading-pi/2);
L=0;
food=1;
while food<=numFood
    L=L+FoodSize(food)*(1/norm([checkX-FoodX(food),checkY-FoodY(food)])^2);
    food=food+1;
end
m=min([F L R B]);
F=F-m;
L=L-m;
R=R-m;
B=B-m;
m=max([F,L,R,B]);
F=F/m;
L=L/m;
R=R/m;
B=B/m;

end

