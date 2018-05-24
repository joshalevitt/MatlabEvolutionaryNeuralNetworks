function [ L,R,F,B,Layer1Activ ] = ForwardProp( Features, Policy, NNStruct )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
numPolicies=length(Policy);
goodNumPolicies=NNStruct(1)*NNStruct(2)+NNStruct(2)+NNStruct(2)*NNStruct(3)+NNStruct(3);
if numPolicies~=goodNumPolicies
    display('improper Policy size');
end

F=Features;

Weights1=reshape(Policy(1:NNStruct(1)*NNStruct(2)),NNStruct(1:2));

Biases1=Policy(NNStruct(1)*NNStruct(2)+1:NNStruct(1)*NNStruct(2)+NNStruct(2));

Layer1Activ=F*Weights1+transpose(Biases1);

Layer1Activ=1./(1+exp(-1*Layer1Activ));

Weights2=reshape(Policy(NNStruct(1)*NNStruct(2)+NNStruct(2)+1:NNStruct(1)*NNStruct(2)+NNStruct(2)+NNStruct(2)*NNStruct(3)),NNStruct(2:3));

Biases2=Policy(NNStruct(1)*NNStruct(2)+NNStruct(2)+NNStruct(2)*NNStruct(3)+1:NNStruct(1)*NNStruct(2)+NNStruct(2)+NNStruct(2)*NNStruct(3)+NNStruct(3));

Layer2Activ=Layer1Activ*Weights2+transpose(Biases2);

Layer2Activ=1./(1+exp(-1*Layer2Activ));

L=Layer2Activ(1);

R=Layer2Activ(2);

F=Layer2Activ(3);

B=Layer2Activ(4);

end

