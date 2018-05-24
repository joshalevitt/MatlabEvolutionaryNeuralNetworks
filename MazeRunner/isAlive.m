function [ alive ] = isAlive( M,X,Y )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if M(floor(Y),floor(X))>0
    alive=1;
else
    alive=0;
end

end

