function [ score ] = CheckPredFitness( PredNN,PredPolicy,Seed )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
rng(round(Seed)*100000);
load('Policys_8_10_4');

FoodX=rand*10;
FoodY=rand*10;
FoodSize=rand*2;
FoodRate=0.03;
numFood=1;
NN=[8,10,4];

Policy=BestPolicys(:,1755);
numParams=length(Policy);

%PredNN=[12,10,4];
%PredPolicy=randn(PredNN(1)*PredNN(2)+PredNN(2)+PredNN(2)*PredNN(3)+PredNN(3)+PredNN(3)*PredNN(4)+PredNN(4),1);
PredX=rand*4+3;
PredY=rand*4+3;
PredHeading=rand*2*pi;
PredHunger=0;
PredAttrition=0.003;
PredTurn=0;
PredMaxSpeed=0.4;
PredSpeed=0;
PredRecover=0.01;
PredFatigue=0;
PredN=0;

difficulty=1;

numPrey=1;
RunnerX=rand*2+4;
RunnerY=rand*2+4;

RunnerHeading=rand*2*pi;
RunnerHunger=0;
RunnerAttrition=0.01;
EatRange=0.2;
maxSpeed=0.3;
turn=0;

h=0;

RunnerSpeed=0;

preyRate=0.01;

PredAlive=1;

score=0;

step=1;
while PredAlive==1 && step<=20000
    prey=1;
    PredN=100;
    while prey<=numPrey
        alive=1;
        %Check for Eaten Food
        food=1;
        n=100;
        while food<=numFood
            temp=norm([RunnerX(prey)-FoodX(food),RunnerY(prey)-FoodY(food)]);
            if temp<EatRange
                RunnerHunger(prey)=RunnerHunger(prey)-FoodSize(food);
                if RunnerHunger(prey)<0
                    RunnerHunger(prey)=RunnerHunger(prey)/2;
                end
                FoodX(food)=[];
                FoodY(food)=[];
                FoodSize(food)=[];
                numFood=numFood-1;
                food=food-1;
            end
            if temp<n
                n=temp;
            end
            food=food+1;
        end

        RunnerHunger(prey)=RunnerHunger(prey)+RunnerAttrition-min([1/(n*100),0.001]);
        if RunnerHunger(prey)>1
            alive=0;
        end
        
        [Fo,B,L,R]=GetFoodDistances(RunnerX(prey),RunnerY(prey),RunnerHeading(prey),FoodX,FoodY,FoodSize);
        features=[Fo,B,L,R,RunnerHunger(prey),RunnerSpeed(prey),turn(prey),n];
        [L,R,Fo,B,Layer1Activ]=ForwardProp(features,Policy(:,prey),NN);
        accel=(Fo-B)/2.5;
        turn(prey)=pi*.2*(R-L);

        RunnerHeading(prey)=RunnerHeading(prey)+turn(prey);
        RunnerSpeed(prey)=accel;
        if RunnerSpeed(prey)<0
            RunnerSpeed(prey)=0;
        elseif RunnerSpeed(prey)>maxSpeed
            RunnerSpeed(prey)=maxSpeed;
        end

        RunnerX(prey)=RunnerX(prey)+sin(RunnerHeading(prey))*RunnerSpeed(prey);
        RunnerY(prey)=RunnerY(prey)+cos(RunnerHeading(prey))*RunnerSpeed(prey);

        if RunnerX(prey)>10
           % RunnerX(prey)=10;
        elseif RunnerX(prey)<0
           % RunnerX(prey)=0;
        end

        if RunnerY(prey)>10
           % RunnerY(prey)=10;
        elseif RunnerY(prey)<0
           % jmRunnerY(prey)=0;
        end
        
        temp=norm([RunnerX(prey)-PredX,  RunnerY(prey)-PredY]);
        if temp<=PredN
            PredN=temp;
        end
        
        if temp<=EatRange
            alive=0;
            PredHunger=1-difficulty;
            score=score+50;
        end
        
        if alive==0
            RunnerX(prey)=[];
            RunnerY(prey)=[];
            RunnerHeading(prey)=[];
            RunnerSpeed(prey)=[];
            RunnerHunger(prey)=[];
            Policy(:,prey)=[];
            turn(prey)=[];
            prey=prey-1;
            numPrey=numPrey-1;
        end
        
        prey=prey+1;
    end
    
    
        
    
    if rand<FoodRate || numFood<2
        %make New Food
        numFood=numFood+1;
        FoodX(numFood)=rand*10;
        FoodY(numFood)=rand*10;
        FoodSize(numFood)=rand;%*difficulty;
    end
    
    [FoodFo,FoodB,FoodL,FoodR]=GetFoodDistances(PredX,PredY,PredHeading,FoodX,FoodY,FoodSize);
    [Fo,B,L,R]=GetFoodDistances(PredX,PredY,PredHeading,RunnerX,RunnerY,ones(size(RunnerX)));
    features=[FoodFo,FoodB,FoodL,FoodR,Fo,B,L,R,PredHunger,PredSpeed,PredTurn,PredN,PredFatigue];
    [L,R,Fo,B,~]=ForwardProp(features,PredPolicy,PredNN);
    accel=(Fo-B)/2.5;
    PredTurn=pi*.2*(R-L);

    if Fo-B>.7
        PredFatigue=PredFatigue+0.04;
    else
        PredFatigue=PredFatigue-PredRecover;
    end
    
    if PredFatigue<0
        PredFatigue=0;
    elseif PredFatigue>1
        PredFatigue=1;
    end
    
    if PredFatigue>0.5
        PredMaxSpeed=0.2;
    else
        PredMaxSpeed=0.5;
    end
    
    PredHeading=PredHeading+PredTurn;
    PredSpeed=accel;
    if PredSpeed<0
        PredSpeed=0;
    elseif PredSpeed>PredMaxSpeed
        PredSpeed=PredMaxSpeed;
    end

    PredX=PredX+sin(PredHeading)*PredSpeed;
    PredY=PredY+cos(PredHeading)*PredSpeed;

    if PredX>15
        PredX=15;
    elseif PredX<-5
        PredX=-5;
    end

    if PredY>15
        PredY=15;
    elseif PredY<-5
        PredY=-5;
    end

    
    PredHunger=PredHunger+PredAttrition;
    
    if PredHunger>1
        PredAlive=0;
    end
    
    if rand<preyRate || numPrey<2
        %make New Food
        numPrey=numPrey+1;
        RunnerX(numPrey)=rand*2+4;
        RunnerY(numPrey)=rand*2+4;
        RunnerHeading(numPrey)=rand*2*pi;
        Policy(:,prey)=BestPolicys(:,1755)+randn(numParams,1)/100;
        RunnerSpeed(numPrey)=0;
        RunnerHunger(prey)=0;
        turn(numPrey)=0;
    end
    
    step=step+1;
    score=score+1;
    
    if PredN<1
       % score=score+1;
    end
    
    if mod(step,1000)==0
        difficulty=difficulty*.9;
    end
end



end

