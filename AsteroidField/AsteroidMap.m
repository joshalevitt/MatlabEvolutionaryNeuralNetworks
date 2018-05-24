
%load('policies_10_5_4_2.mat');
F=figure;
plot(0)
xlim([0,20])
ylim([0,20])
NN=[10,5,4];

Policy=BestPolicys(:,146);
%Policy=mean(Policys,2);
%Policy=randn(NN(1)*NN(2)+NN(2)+NN(2)*NN(3)+NN(3),1);
astercount=1;
numAsteroid=1;
[X,Y,H,Si,Speed,col ]=initAsteroid(rand);
asterX=X;
asterY=Y;
asterHeading=H;
asterSize=Si;
asterSpeed=Speed;
asterXCorr=asterSize(astercount)*sin(linspace(1,2*pi,13))+asterX(astercount);
asterYCorr=asterSize(astercount)*cos(linspace(1,2*pi,13))+asterY(astercount);
aster=patch(asterXCorr,asterYCorr,col);

RunnerX=rand*10+5;
RunnerY=rand*10+5;
PatchHeight=1.5;
RunnerHeading=rand*2*pi;
PatchSize=.5;
RunnerSpeed=0;
maxSpeed=0.4;

[xp,yp,cp]=MakePatchCoords(RunnerX,RunnerY,RunnerHeading);
p=patch(xp,yp,cp);
StepSize=0.1;
alive=1;
numSteps=10000;
difficulty=0.03;

step=1;
while alive==1;
    delete(p);
    astercount=1;
    while astercount<=length(asterX)
        asterX(astercount)=asterX(astercount)+asterSpeed(astercount)*sin(asterHeading(astercount));
        asterY(astercount)=asterY(astercount)+asterSpeed(astercount)*cos(asterHeading(astercount));
        asterXCorr=asterSize(astercount)*cos(linspace(1,2*pi,13))+asterX(astercount);%(astercount);
        asterYCorr=asterSize(astercount)*sin(linspace(1,2*pi,13))+asterY(astercount);
        aster(astercount).XData=asterXCorr;
        aster(astercount).YData=asterYCorr;
        if asterIsAlive(asterX(astercount),asterY(astercount),asterSize(astercount))==0
            asterX(astercount)=[];
            asterY(astercount)=[];
            asterSize(astercount)=[];
            asterSpeed(astercount)=[];
            asterHeading(astercount)=[];
            aster(astercount)=[];
            astercount=astercount-1;
            numAsteroid=numAsteroid-1;
        end
        astercount=astercount+1;
    end
    if rand<difficulty
        numAsteroid=numAsteroid+1;
        [X,Y,H,Si,Speed,col ]=initAsteroid(rand);
        asterX(numAsteroid)=X;
        asterY(numAsteroid)=Y;
        asterHeading(numAsteroid)=H;
        asterSize(numAsteroid)=Si;
        asterSpeed(numAsteroid)=Speed;
        asterXCorr=asterSize(numAsteroid)*sin(linspace(1,2*pi,13))+asterX(numAsteroid);
        asterYCorr=asterSize(numAsteroid)*cos(linspace(1,2*pi,13))+asterY(numAsteroid);
        aster(numAsteroid)=patch(asterXCorr,asterYCorr,col);
    end
    [Left,FLeft,Front,FRight,Right,BRight,Back,BLeft]=GetDistances(RunnerX,RunnerY,RunnerHeading,asterX,asterY,asterSize);
    features=[Left,FLeft,Front,FRight,Right,BRight,Back,BLeft,turn,RunnerSpeed];
    [L,R,Fo,B,Layer1Activ]=ForwardProp(features,Policy,NN);
    accel=(Fo-B)/2.5;
    turn=pi*.1*(R-L);
    
    RunnerHeading=RunnerHeading+turn;
    RunnerSpeed=accel;
    if RunnerSpeed<-1*maxSpeed
        RunnerSpeed=-1*maxSpeed;
    elseif RunnerSpeed>maxSpeed
        RunnerSpeed=maxSpeed;
    end

    RunnerX=RunnerX+sin(RunnerHeading)*RunnerSpeed;
    RunnerY=RunnerY+cos(RunnerHeading)*RunnerSpeed;
    [xp,yp,cp]=MakePatchCoords(RunnerX,RunnerY,RunnerHeading);
    p=patch(xp,yp,cp);
    
    alive=isAlive(RunnerX,RunnerY,asterX,asterY,asterSize);
    frames(step)=getframe(F);
    step=step+1;
    
    if mod(step,100)==0
        difficulty=difficulty+0.002;
    end
end