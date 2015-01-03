function [X] = SampleUniformMin(st,ed,N)
%sample min of N uniform varable
%could be vectors

X = min((st * ones(1,N) + ((ed - st) * ones(1,N)).* rand(size(st,1),N)),[],2);


end
