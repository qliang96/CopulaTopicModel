function [mu,Sigma] = NPNFit(Eta)
%fit NPN on Eta (D \times K), Eta is the sample mean
% no need to fit the marginal cdf as it is ecdf of Eta.


EtaMean = mean(Eta)'; %k dim
EtaStd = std(Eta)'; %k dim one for each topic

% F = zeros(size(Eta));
m=size(Eta,1);
pho = 1/(4 * m^0.25 * sqrt(pi * log(m)));
[~,I] = sort(Eta,2);
F = I/m;
F = max(F,pho);
F = min(F, 1 - pho);  %truncate F
f = ones(m,1) * EtaMean' + ones(m,1) * EtaStd' .* norminv(F);
%f is a D \times K matrix, each row is the f of a doc (one data point to
%fit)
mu = mean(f)';
Sigma = cov(f);
return

