function [ alive ] = asterIsAlive( asterX,asterY,asterSize )
%ASTERISALIVE Summary of this function goes here
%   Detailed explanation goes here
alive=1;
if asterX-asterSize>20||asterX+asterSize<0||asterY-asterSize>20||asterY+asterSize<0
    alive=0;
end

end

