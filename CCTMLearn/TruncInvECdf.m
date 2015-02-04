function [x] = TruncInvECdf(X,F)
%the inverse of Trunc inverse ECdf
%  X, m: data for ECdf
%F is the function value
%return the x = F^{-1}()

%can I make this a matrix operation?

m =size(X,1);
[f,Y]=ecdf(X);
pho = 1/(4 * m^0.25 * sqrt(pi * log(m)));

if F <= pho
    x = min(X);
    return
end
if F >= 1 - pho
    x = max(X);
    return
end

x = max(Y(f < F));


end

