function [X] = SampleUniformMax(st,ed,N)
%sample max of N uniform varable
%could be vectors
% st
% ed
% N
X = zeros(size(st,1),1);
for i=1:size(X,1)
    if N(i) == 0        
        continue
    end
    X(i) = max(st(i) * ones(N(i),1) + (ed(i)-st(i)) * rand(N(i),1)); 
end

