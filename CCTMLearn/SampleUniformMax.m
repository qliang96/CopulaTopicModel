function [X] = SampleUniformMax(st,ed,N)
%sample max of N uniform varable
%could be vectors
% st
% ed
% N
f=rand(size(st));
X = f.^(1.0./N).*(ed - st) + st;
X(N==0)=0;
