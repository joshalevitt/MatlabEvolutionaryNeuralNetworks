
NN=[10,10,4];
numSpecies=50;
numGenerations=20000;
numPolicys=NN(1)*NN(2)+NN(2)+NN(2)*NN(3)+NN(3);

rng(1)

% PreyPolicys=randn(numPolicys,numSpecies);
% Fitnesses=ones(numSpecies,1);
% PreyBestFitnesses=zeros(numGenerations,1);
% PreyBestPolicys=zeros(numPolicys,numGenerations);
% MeanFitnesses=zeros(numGenerations,1);
% 
% generation=1;

while generation<=numGenerations
    PreyPolicys=MakeNewPolicys(PreyPolicys,Fitnesses);
    species=1;
    rng shuffle
    seed=rand;

    while species<=numSpecies
        Fitnesses(species)=CheckPreyFitness(NN,PreyPolicys(:,species),seed);    
        species=species+1;
    end
    [M,I]=max(Fitnesses);
    PreyBestFitnesses(generation)=M;
    me=mean(Fitnesses)
    MeanFitnesses(generation)=me;
    PreyBestPolicys(:,generation)=PreyPolicys(:,I);
    
    %Policys=randn(42,numSpecies);
    M
    generation=generation+1
end
figure
plot(PreyBestFitnesses);
hold on 
plot(MeanFitnesses);
hold off
