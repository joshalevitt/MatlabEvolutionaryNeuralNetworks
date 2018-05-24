load('Maze2.mat');
M=Maze2;
[H,W]=size(M);
[X,Y]=meshgrid(1:1:H,1:1:W);
Policy=BestPolicys(:,400);
NN=[5,5,2];
F=figure;
subplot(1,2,2)
surf(X,Y,M,'EdgeColor','none');
view(2)
hold on
RunnerX=3.5;
RunnerY=2.5;
RunnerZ=2;
PatchHeight=1.5;
RunnerHeading=90;
PatchSize=.5;
PatchTipX=RunnerX+sin(degtorad(RunnerHeading))*PatchSize;
PatchTipY=RunnerY+cos(degtorad(RunnerHeading))*PatchSize;
PatchBackRX=RunnerX+sin(degtorad(RunnerHeading+160))*PatchSize;
PatchBackRY=RunnerY+cos(degtorad(RunnerHeading+160))*PatchSize;
PatchBackLX=RunnerX+sin(degtorad(RunnerHeading+200))*PatchSize;
PatchBackLY=RunnerY+cos(degtorad(RunnerHeading+200))*PatchSize;

Weights1=reshape(Policy(1:NN(1)*NN(2)),NN(1:2));
startX1=0.07;
endX1=0.2;
Y1=[.9,.69,.48,.27,.06];
i=1;
while i<=NN(1)
    j=1;
    while j<=NN(2)
        if Weights1(i,j)>0
            activ=1;
        else
            activ=0;
        end
        %activation1=1/(1+exp(-1*(Weights1(i,j))));
        %activation2=1/(1+exp(1*(Weights1(i,j))));
        annotation('line','X',[startX1,endX1],'Y',[Y1(i),Y1(j)],'Color',[activ,0,1-activ],'LineWidth',abs(Weights1(i,j)));
        j=j+1;
    end
    i=i+1;
end

Weights2=reshape(Policy(NN(1)*NN(2)+NN(2)+1:NN(1)*NN(2)+NN(2)+NN(2)*NN(3)),NN(2:3));
startX1=0.26;
endX1=0.4;
startY1=[.9,.69,.48,.27,.06];
endY1=[.8,.3];
i=1;
while i<=NN(2)
    j=1;
    while j<=NN(3)
        if Weights2(i,j)>0
            activ=1;
        else
            activ=0;
        end
        %activation1=1/(1+exp(-1*(Weights2(i,j))));
        %activation2=1/(1+exp(1*(Weights2(i,j))));
        annotation('line','X',[startX1,endX1],'Y',[startY1(i),endY1(j)],'Color',[activ,0,1-activ],'LineWidth',abs(Weights2(i,j)));
        j=j+1;
    end
    i=i+1;
end

%activation=1/(1+exp(-1*(Features(1)-14)));
LT=annotation('textbox',[.01,.85,.06,.1],'String',' ','EdgeColor',[1,0,0]);

%activation=1/(1+exp(-1*(Features(2)-14)));
LF=annotation('textbox',[.01,.64,.06,.1],'String',' ','EdgeColor',[1,0,0]);

%activation=1/(1+exp(-1*(Features(3)-14)));
FT=annotation('textbox',[.01,.43,.06,.1],'String',' ','EdgeColor',[1,0,0]);

%activation=1/(1+exp(-1*(Features(4)-14)));
RF=annotation('textbox',[.01,.22,.06,.1],'String',' ','EdgeColor',[1,0,0]);

%activation=1/(1+exp(-1*(Features(5)-14)));
RT=annotation('textbox',[.01,.01,.06,.1],'String',' ','EdgeColor',[1,0,0]);

L1=annotation('textbox',[.2,.85,.06,.1],'String',' ','EdgeColor',[1,0,0]);

L2=annotation('textbox',[.2,.64,.06,.1],'String',' ','EdgeColor',[1,0,0]);

L3=annotation('textbox',[.2,.43,.06,.1],'String',' ','EdgeColor',[1,0,0]);

L4=annotation('textbox',[.2,.22,.06,.1],'String',' ','EdgeColor',[1,0,0]);

L5=annotation('textbox',[.2,.01,.06,.1],'String',' ','EdgeColor',[1,0,0]);

O1=annotation('textbox',[.4,.75,.08,.1],'String',' ','EdgeColor',[1,0,0]);

O2=annotation('textbox',[.4,.25,.08,.1],'String',' ','EdgeColor',[1,0,0]);


[xp,yp,zp,cp]=MakePatchCoords(RunnerX,RunnerY,RunnerZ,RunnerHeading);
p=patch(xp,yp,zp,cp);
StepSize=0.1;
alive=1;

step=1;
while alive==1
    delete(p);
    [Left,FLeft,Front,FRight,Right]=GetDistances(M,RunnerX,RunnerY,RunnerHeading);
    Features=[Left,FLeft,Front,FRight,Right];
    
    [L,R,activs]=ForwardProp(Features,Policy,NN);
    
    activation=1/(1+exp(-1*(Features(1)-14)));
    LT.EdgeColor=[activation,0,0];
    LT.String=num2str(Features(1));
    activation=1/(1+exp(-1*(Features(2)-14)));
    LF.EdgeColor=[activation,0,0];
    LF.String=num2str(Features(2));
    activation=1/(1+exp(-1*(Features(3)-14)));
    FT.EdgeColor=[activation,0,0];
    FT.String=num2str(Features(3));
    activation=1/(1+exp(-1*(Features(4)-14)));
    RF.EdgeColor=[activation,0,0];
    RF.String=num2str(Features(4));
    activation=1/(1+exp(-1*(Features(5)-14)));
    RT.EdgeColor=[activation,0,0];
    RT.String=num2str(Features(5));
    
    L1.EdgeColor=[activs(1),0,0];
    L1.String=num2str(activs(1));
    L2.EdgeColor=[activs(2),0,0];
    L2.String=num2str(activs(2));
    L3.EdgeColor=[activs(3),0,0];
    L3.String=num2str(activs(3));
    L4.EdgeColor=[activs(4),0,0];
    L4.String=num2str(activs(4));
    L5.EdgeColor=[activs(5),0,0];
    L5.String=num2str(activs(5));
    
    O1.EdgeColor=[L,0,0];
    O1.String=num2str(L);
    O2.EdgeColor=[R,0,0];
    O2.String=num2str(R);
    
    RunnerHeading=RunnerHeading+R*10;
    RunnerHeading=RunnerHeading-L*10;
    RunnerX=RunnerX+sin(degtorad(RunnerHeading))*StepSize;
    RunnerY=RunnerY+cos(degtorad(RunnerHeading))*StepSize;
    [xp,yp,zp,cp]=MakePatchCoords(RunnerX,RunnerY,RunnerZ,RunnerHeading);
    p=patch(xp,yp,zp,cp);
    frames(step)=getframe(F);
    M(floor(RunnerY),floor(RunnerX))=M(floor(RunnerY),floor(RunnerX))-0.04;
    alive=isAlive(M,RunnerX,RunnerY);
    step=step+1
end

hold off
