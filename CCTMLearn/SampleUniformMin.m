function [X] = SampleUniformMin(st,ed,N)
%sample min of N uniform varable
%could be vectors

X = ones(size(st));
for i=1:size(X,1)
    if N(i) == 0        
        continue
    end
    X(i) = min(st(i) * ones(N(i),1) + (ed(i)-st(i)) * rand(N(i),1)); 
end
