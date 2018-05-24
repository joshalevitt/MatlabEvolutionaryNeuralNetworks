function [ NewPolicys ] = MakeNewPolicys( OldPolicys, Fitness )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

%rng(1);

[NumParams,NumSpecies]=size(OldPolicys);
NewPolicys=zeros(NumParams,NumSpecies);

Fitness=Fitness.^2;
Fitness=(Fitness)/sum(Fitness);
cumFitness=cumsum(Fitness);
[~,I]=max(Fitness);

species=1;
while species<NumSpecies
    choice1=rand;
    i=1;
    while choice1>=cumFitness(i)
        i=i+1;
    end
    choice2=rand;
    j=1;
    while choice2>=cumFitness(j)
        j=j+1;
    end
    param=1;
    while param<=NumParams
        if rand>.5
            choice=i;
        else
            choice=j;
        end
        if rand<=.99
            NewPolicys(param,species)=OldPolicys(param,choice);
        else
            NewPolicys(param,species)=randn;
        end
        param=param+1;
    end
    species=species+1;
end

NewPolicys(:,species)=randn(NumParams,1);
NewPolicys(:,1:round(NumSpecies/2))=NewPolicys(:,1:round(NumSpecies/2))+randn(NumParams,round(NumSpecies/2))/100;
NewPolicys(:,species-1)=OldPolicys(:,I);
end

