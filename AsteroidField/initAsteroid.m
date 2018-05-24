function [ asterX,asterY,asterHeading,asterSize,asterSpeed,asterCol ] = initAsteroid(blah)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
rng(round(blah*100000));

r=rand;
if r<.25
    asterX=0;
    asterY=rand*20;
    asterHeading=rand*pi/2+pi/4;
elseif r<.5
    asterX=rand*20;
    asterY=0;
    asterHeading=rand*pi/2-pi/4;
elseif r<.75
    asterX=20;
    asterY=rand*20;
    asterHeading=rand*pi/2+pi/4-pi;
else
    asterX=rand*20;
    asterY=20;
    asterHeading=rand*pi/2-pi/4-pi;
end
asterSize=rand*4;
asterSpeed=rand*.2;
asterCol=[rand rand rand];

end

