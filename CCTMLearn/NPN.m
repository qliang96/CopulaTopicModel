function [Eta_k] = NPN(mu,Sigma,NPNEta)
%sample one eta vector (K) from NPN
    %mu, Signa, NPNEta is the parameter of NPN
%will call TruncEcdf() and TruncInvEcdf() as F and F^-1()

% Sigma
% F = copularnd('Gaussian',Sigma,1) + mu;
F = normcdf(mvnrnd(mu,Sigma,1))';
% k = size(mu,1);
% [m,k]=size(NPNEta);
Eta_k = zeros(size(F));
for i=1:size(Eta_k,1)
    Eta_k(i) = TruncInvECdf(NPNEta(:,i),F(i));
end
% Eta_k

