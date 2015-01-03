function [W,Z,Phi] = SimulationDataGeneration(m,k,V,beta,mu,Sigma,MarginalType)
%simulate data from given paramerters:
%m: num of doc; k num of topic; V vocabulary size; beta Dir prior
%mu, Sigma: parameter of Copula
%MarginalType: gaussian, uniform
%sample the doc-word mtx W, their topic assignment Z, and topic word mtx
    %Phi
%W,Z is sparse mtx, before spconvert!!!!

Phi = SampleTopicWordMtx(k,V,beta);

TermPerDoc = ceil(0.01 * V);
W = zeros(m * TermPerDoc,3);
Z = zeros(m * TermPerDoc,3);
cnt = 1;
for i=1:m
    eta = SampleFromNPN(mu,Sigma,MarginalType);
    Prob = exp(eta) ./ sum(exp(eta));
    for j=1:TermPerDoc       
        t = find(mnrnd(1,Prob,1));
        Wn = find(mnrnd(1,Phi(j,:),1));
        
  
        W(cnt,:) = [i,Wn,1];
        Z(cnt,:) = [i,Wn,t];
        cnt  = cnt + 1;
    end
    fprintf('sampled [%d] doc, [%d] term\n',i,TermPerDoc);
end

%W = spconvert(W);
%Z = spconvert(Z);

return
