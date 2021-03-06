
NN=[8,10,4];
numSpecies=50;
numGenerations=20000;
numPolicys=NN(1)*NN(2)+NN(2)+NN(2)*NN(3)+NN(3);

%rng(1)

% Policys=randn(numPolicys,numSpecies);
% Fitnesses=ones(numSpecies,1);
% BestFitnesses=zeros(numGenerations,1);
% BestPolicys=zeros(numPolicys,numGenerations);
% MeanFitnesses=zeros(numGenerations,1);
% 
% generation=1;

while generation<=numGenerations
    Policys=MakeNewPolicys(Policys,Fitnesses);
    species=1;
    rng shuffle
    seed=rand;

    while species<=numSpecies
        Fitnesses(species)=CheckFitness(NN,Policys(:,species),seed);    
        species=species+1;
    end
    [M,I]=max(Fitnesses);
    BestFitnesses(generation)=M;
    me=mean(Fitnesses)
    MeanFitnesses(generation)=me;
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