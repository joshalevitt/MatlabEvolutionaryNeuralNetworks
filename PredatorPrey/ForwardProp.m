function [ L,R,F,B,LayerActiv ] = ForwardProp( Features, Policy, NNStruct )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
numPolicies=length(Policy);

goodNumPolicies=0;
layer=2;
while layer<=length(NNStruct)
    goodNumPolicies=goodNumPolicies+NNStruct(layer);
    goodNumPolicies=goodNumPolicies+NNStruct(layer)*NNStruct(layer-1);
    layer=layer+1;
end
if numPolicies~=goodNumPolicies
    display('improper Policy size');
end

LayerActiv=Features;
layer=1;
index=1;
while layer<length(NNStruct)
    Weights=reshape(Policy(index:index-1+NNStruct(layer)*NNStruct(layer+1)),NNStruct(layer:layer+1));

    Biases=Policy(index+NNStruct(layer)*NNStruct(layer+1):index-1+NNStruct(layer)*NNStruct(layer+1)+NNStruct(layer+1));
    
    LayerActiv=LayerActiv*Weights+transpose(Biases);

    LayerActiv=1./(1+exp(-1*LayerActiv));
    
    index=index+NNStruct(layer)*NNStruct(layer+1)+NNStruct(layer+1);
    
    layer=layer+1;
end


L=LayerActiv(1);

R=LayerActiv(2);

F=LayerActiv(3);

B=LayerActiv(4);

end

