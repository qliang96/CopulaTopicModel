function [ F ] = TruncECdf(X,m,x)
%the trucated ecdf of X. m is the cut point, x is the F(x)

[f,Y] = ecdf(X);
F=max(f(Y<=x));
pho = 1/(4 * m^0.25 * sqrt(pi * log(m)));
F = max(pho,F);
F = min(F,1 - pho);


