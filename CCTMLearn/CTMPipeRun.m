function [ flag] = CTMPipeRun(InName,OutDir,beta,k)
%run CTM, and dump the Eta and Phi
%InName: the doc - word matrix W, in sparse format
%beta, k: dir prior, and num of topic
%OutDir: the place to output. will dump 4 csv format files:
    %/phi
    %/Eta
    %/mu
    %/sigma
    

flag = 1;

SpW = csvread(InName);
W = spconvert(SpW);
[mu,Sigma, Eta,Phi] = CopulaCTM(W,beta,k);
fprintf('model train complete\n');
csvwrite(strcat(OutDir,'/mu'),mu);
csvwrite(strcat(OutDir,'/sigma'),Sigma);
csvwrite(strcat(OutDir,'/eta'),Eta);
csvwrite(strcat(OutDir,'/phi'),Phi);    

end

