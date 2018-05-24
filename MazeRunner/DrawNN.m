function [ ] = DrawNN(Features,Policy,NNStruct )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
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



figure
subplot(1,2,2)
plot(Features)
activation=1/(1+exp(-1*(Features(1)-14)));
LT=annotation('textbox',[.01,.85,.06,.1],'String',num2str(Features(1)),'EdgeColor',[activation,0,0]);

activation=1/(1+exp(-1*(Features(2)-14)));
LF=annotation('textbox',[.01,.64,.06,.1],'String',num2str(Features(2)),'EdgeColor',[activation,0,0]);

activation=1/(1+exp(-1*(Features(3)-14)));
FT=annotation('textbox',[.01,.43,.06,.1],'String',num2str(Features(3)),'EdgeColor',[activation,0,0]);

activation=1/(1+exp(-1*(Features(4)-14)));
RF=annotation('textbox',[.01,.22,.06,.1],'String',num2str(Features(4)),'EdgeColor',[activation,0,0]);

activation=1/(1+exp(-1*(Features(5)-14)));
RT=annotation('textbox',[.01,.01,.06,.1],'String',num2str(Features(5)),'EdgeColor',[activation,0,0]);

L1=annotation('textbox',[.2,.85,.06,.1],'String',num2str(Layer1Activ(1)),'EdgeColor',[Layer1Activ(1),0,0]);

L2=annotation('textbox',[.2,.64,.06,.1],'String',num2str(Layer1Activ(2)),'EdgeColor',[Layer1Activ(2),0,0]);

L3=annotation('textbox',[.2,.43,.06,.1],'String',num2str(Layer1Activ(3)),'EdgeColor',[Layer1Activ(3),0,0]);

L4=annotation('textbox',[.2,.22,.06,.1],'String',num2str(Layer1Activ(4)),'EdgeColor',[Layer1Activ(4),0,0]);

L5=annotation('textbox',[.2,.01,.06,.1],'String',num2str(Layer1Activ(5)),'EdgeColor',[Layer1Activ(5),0,0]);

O1=annotation('textbox',[.4,.75,.08,.1],'String',num2str(Layer2Activ(1)),'EdgeColor',[Layer2Activ(1),0,0]);

O2=annotation('textbox',[.4,.25,.08,.1],'String',num2str(Layer2Activ(2)),'EdgeColor',[Layer2Activ(1),0,0]);

end

