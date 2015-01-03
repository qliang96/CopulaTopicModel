function [mu,Sigma, Eta] = CopulaCTM(W,beta)
%learn the copula topic model parameters from W(doc-word mtx) and beta (dir
%prior)
%mu,Sigma: the parameter for NPN
%Eta the Doc-topic prob mtx (DK), used to estimate the empirical cdf F in
%NPN

%will call GibbsSample(), and NPNFit() as E step and M step


end

