function [X] = SampleUniformMax(st,ed,N)
%sample max of N uniform varable
%could be vectors

X = max((st * ones(1,N) + ((ed - st) * ones(1,N)).* rand(size(st,1),N)),[],2);


end

