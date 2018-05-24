function [ NewPolicys ] = MakeNewPolicys( OldPolicys, Fitness )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
[NumParams,NumSpecies]=size(OldPolicys);
NewPolicys=zeros(NumParams,NumSpecies);

Fitness=Fitness.^2;
Fitness=(Fitness)/sum(Fitness);
cumFitness=cumsum(Fitness);
[M,I]=max(Fitness);

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
        if rand>1
            choice=i;
        else
            choice=j;
        end
        if rand<=.98
            NewPolicys(param,species)=OldPolicys(param,choice);
        else
            NewPolicys(param,species)=randn;
        end
        param=param+1;
    end
    species=species+1;
end

NewPolicys(:,species)=randn(NumParams,1);
NewPolicys=NewPolicys+randn(NumParams,NumSpecies)/100;
NewPolicys(:,species-1)=OldPolicys(:,I);
end

