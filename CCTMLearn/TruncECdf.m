function [ F ] = TruncECdf(X,x)
%the trucated ecdf of X. m is the cut point, x is the F(x)
%can I make this a matrix operation?

m=size(X,1);
[f,Y] = ecdf(X);
if x < min(Y)
    F = 0;
else
    F=max(f(Y<=x));
end
pho = 1/(4 * m^0.25 * sqrt(pi * log(m)));
F = max(pho,F);
F = min(F,1 - pho);


