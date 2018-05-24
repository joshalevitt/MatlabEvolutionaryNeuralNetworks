%load('Policys_8_5_4');
rng(round(.123)*100000);
rand
FoodX=rand*10;
FoodY=rand*10;
FoodSize=rand;
FoodRate=0.025;
numFood=1;
NN=[8,10,4];
%Policy=randn(NN(1)*NN(2)+NN(2)+NN(2)*NN(3)+NN(3),1);
Policy=BestPolicys(:,1755);
Policy(84)=0;

difficulty=1;
F=figure;
s=scatter(FoodX,FoodY,FoodSize*100,[0,1,0],'filled');
hold on

RunnerX=rand*2+4;
RunnerY=rand*2+4;
PatchHeight=1.5;
RunnerHeading=rand*2*pi;
RunnerHunger=0;
RunnerAttrition=0.01;
EatRange=0.2;
maxSpeed=0.3;
turn=0;

h=0;

RunnerSpeed=0;

alive=1;

[xp,yp,cp]=MakePatchCoords(RunnerX,RunnerY,RunnerHeading);
p=patch(xp,yp,cp);

xlim([-10,20])
ylim([-10,20])


step=1;
while alive==1
    
    %Check for Eaten Food
    food=1;
    n=100;
    while food<=numFood
        temp=norm([RunnerX-FoodX(food),RunnerY-FoodY(food)]);
        if temp<EatRange
            RunnerHunger=RunnerHunger-FoodSize(food);
            if RunnerHunger<0
                RunnerHunger=RunnerHunger/2;
            end
            FoodX(food)=[];
            FoodY(food)=[];
            FoodSize(food)=[];
            numFood=numFood-1;
            food=food-1;
            if numFood>0
                delete(s)
                s=scatter(FoodX,FoodY,FoodSize*100,[0,1,0],'filled');
            end
            display('ate a food')
            step
        end
        if temp<n
            n=temp;
        end
        food=food+1;
    end
    
    RunnerHunger=RunnerHunger+RunnerAttrition-min([1/(n*1000),0.001]);
    if RunnerHunger>1
        alive=0;
    end
    
    if rand<FoodRate || numFood<2
        %make New Food
        numFood=numFood+1;
        FoodX(numFood)=rand*10;
        FoodY(numFood)=rand*10;
        FoodSize(numFood)=rand*difficulty;
        delete(s)
        s=scatter(FoodX,FoodY,FoodSize*100,[0,1,0],'filled');
    end
    
    [Fo,B,L,R]=GetFoodDistances(RunnerX,RunnerY,RunnerHeading,FoodX,FoodY,FoodSize);
    features=[Fo,B,L,R,RunnerHunger,RunnerSpeed,turn,n];
    
    [L,R,Fo,B,~]=ForwardProp(features,Policy,NN);
    accel=(Fo-B)/2.5;
    turn=pi*.1*(R-L);
    
    RunnerHeading=RunnerHeading+turn;
    RunnerSpeed=accel;
    if RunnerSpeed<0
        RunnerSpeed=0;
    elseif RunnerSpeed>maxSpeed
        RunnerSpeed=maxSpeed;
    end

    RunnerX=RunnerX+sin(RunnerHeading)*RunnerSpeed;
    RunnerY=RunnerY+cos(RunnerHeading)*RunnerSpeed;
    
    if RunnerX>10
        %RunnerX=10;
    elseif RunnerX<0
        %RunnerX=0;
    end
    
    if RunnerY>10
        %RunnerY=10;
    elseif RunnerY<0
        %RunnerY=0;
    end
    
    [xp,yp,cp]=MakePatchCoords(RunnerX,RunnerY,RunnerHeading);
    delete(p);
    p=patch(xp,yp,cp);
    
    h(step)=RunnerHunger;
    step=step+1;
    frames(step)=getframe(F);
    if mod(step,1000)==0
        difficulty=difficulty*.9;
    end
end
step
