function eta = SampleFromNPN(mu,Sigma,MarginalType)
%sample one eta from the NPN
%mu, sigma is the para of gaussian copula
%MarginalType: gaussian, uniform,exponetial

F =  copularad('Gaussian',Sigma,1) + mu;
eta = zeros(size(mu));
if strcmp(MarginalType,'gaussian')
    eta = norminv(F,0,1);
end

if strcmp(MarginalType,'uniform')
    eta = F;
end

if strcmp(MarginalType,'exponential')
   eta = expinv(F); 
end



