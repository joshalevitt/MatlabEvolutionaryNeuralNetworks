
function [ p ] = softMax( a, vals, b )
%The softmax function I'm using.
%it accepts three inputs: an index, a value set, and a beta parameter
%it returns the probability of the value at the given index, given the beta
%parameter.

i=1;
sum=0;
while i<=length(vals)
    sum=sum+exp(b*vals(i));
    i=i+1;
end

p=exp(b*vals(a))/sum;


end

