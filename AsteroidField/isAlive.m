function [ alive ] = isAlive( runnerX,runnerY,asterX,asterY,asterSize )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
alive=1;
l=length(asterX);
if runnerX<0||runnerY<0||runnerX>20||runnerY>20
    alive=0;
else
    %l=length(asterX);
    %blocks=[ones(l,1)*runnerX-transpose(asterX);ones(l,1)*runnerY-transpose(asterY)];
    i=1;
    while i<=length(asterX)
        if norm([runnerX-asterX(i),runnerY-asterY(i)])<asterSize(i)
            alive=0;
        end
        i=i+1;
    end

end

