load('Maze2.mat');
Maze=Maze2;
NN=[5,5,2];
numSpecies=70;
numGenerations=400;
numPolicys=NN(1)*NN(2)+NN(2)+NN(2)*NN(3)+NN(3);

Policys=randn(numPolicys,numSpecies);
Fitnesses=ones(numSpecies,1);
BestFitnesses=zeros(numGenerations,1);
BestPolicys=zeros(numPolicys,numGenerations);
MeanFitnesses=zeros(numGenerations,1);

generation=1;

while generation<=numGenerations
    Policys=MakeNewPolicys(Policys,Fitnesses);
    species=1;
    while species<=numSpecies
        Fitnesses(species)=FitnessChecker(Policys(:,species),Maze,NN);    
        species=species+1;
    end
    [M,I]=max(Fitnesses);
    BestFitnesses(generation)=M;
    MeanFitnesses(generation)=mean(Fitnesses);
    BestPolicys(:,generation)=Policys(:,I);
    
    %Policys=randn(42,numSpecies);
    M
    generation=generation+1
end
figure
plot(BestFitnesses);
hold on 
plot(MeanFitnesses);
hold off