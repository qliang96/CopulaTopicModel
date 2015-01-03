function [Eta_k] = NPN(mu,Sigma,NPNEta)
%sample one eta vector (K) from NPN
    %mu, Signa, NPNEta is the parameter of NPN
%will call TruncEcdf() and TruncInvEcdf() as F and F^-1()


F = copularad('Gaussian',Sigma,1) + mu;
m=size(NPNEta,1);
Eta_k = zeros(k,1);
for i=1:k
    Eta_k(i) = TruncInvECdf(NPNEta(:,i),m,F(i));
end

