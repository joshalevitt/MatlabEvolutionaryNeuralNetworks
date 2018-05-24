
NN=[13,10,8,4];
numSpecies=50;
numGenerations=20000;
numPolicys=NN(1)*NN(2)+NN(2)+NN(2)*NN(3)+NN(3)+NN(3)*NN(4)+NN(4);

rng(1)

% PredPolicys=randn(numPolicys,numSpecies);
% Fitnesses=ones(numSpecies,1);
% PredBestFitnesses=zeros(numGenerations,1);
% PredBestPolicys=zeros(numPolicys,numGenerations);
% MeanFitnesses=zeros(numGenerations,1);
% 
% generation=1;

while generation<=numGenerations
    PredPolicys=MakeNewPolicys(PredPolicys,Fitnesses);
    species=1;
    rng shuffle
    seed=rand;

    while species<=numSpecies
        Fitnesses(species)=CheckPredFitness(NN,PredPolicys(:,species),seed);    
        species=species+1;
    end
    [M,I]=max(Fitnesses);
    PredBestFitnesses(generation)=M;
    me=mean(Fitnesses)
    MeanFitnesses(generation)=me;
    PredBestPolicys(:,generation)=PredPolicys(:,I);
    
    %Policys=randn(42,numSpecies);
    M
    generation=generation+1
end
figure
plot(PredBestFitnesses);
hold on 
plot(MeanFitnesses);
hold off
