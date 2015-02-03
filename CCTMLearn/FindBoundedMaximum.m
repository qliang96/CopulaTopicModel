function [ MaxV ] = FindBoundedMaximum(mu,Sigma,GLower,GUpper)
%find the maximum in the bound
%if mu in it, then it is mvnpdf(mu,mu,sigma);
%otherwise has to solve a qp
% 
% if sum(mu < GLower) + sum(mu > Gupper) == 0
%     MaxV = mvnpdf(mu,mu,Sigma);
%     return
% end

% fprintf('bound\n');
% for i=1:size(GLower,1)
%     fprintf('%f - %f\n',GLower(i) - mu(i),GUpper(i)- mu(i));
% end

%move a little space between bounds
GLower(GLower==GUpper) = GLower(GLower==GUpper) - 0.0001;
GUpper(GLower==GUpper) = GUpper(GLower==GUpper) + 0.0001;
%solve the qp at mean 0
opts = struct( ...    
    'Display','off'...  
    );
x = quadprog(inv(Sigma),zeros(size(mu)),[],[],[],[],GLower-mu,GUpper-mu,[],opts);
x = x + mu;  %center back at mu
MaxV = mvnpdf(x,mu,Sigma);
