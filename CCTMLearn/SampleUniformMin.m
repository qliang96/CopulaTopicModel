function [X] = SampleUniformMin(st,ed,N)
%sample min of N uniform varable
%could be vectors

f=rand(size(st));
X = ed - (1-f).^(1./N).*(ed-st);
X(N==0) = 1;
