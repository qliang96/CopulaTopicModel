function [ flag ] = CopulaCTMPipe(NumOfTopic,OutName)
%copula pipeline runs
%data path is hard coded
InName = '/bos/usr0/cx/tmp/CopulaTopicModel/nips12raw_str602.mat';
load(InName);
k=ceil(str2double(NumOfTopic));
beta = 0.01;
[mu,Sigma, Eta,Phi]=CopulaCTM(counts',beta,k);
DumpWordTopic(wl,Phi,OutName);
flag = 1;



