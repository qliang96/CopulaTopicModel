function [ Eta_d ] = SampleBoundedNPN(mu,Sigma,NPNEta,Lower,Upper)
%sample one doc's Eta_d from the NPN, with bound lower-upper on Eta_d
%1: transfer the bound in Eta_d, to the Gaussian's \phi^{-1}F(\eta) space
%2: use rejection sampling to sample from the bounded Gaussian
    %use the mean as max, if mutiple times still rejected, then just sample
    %from uniform for now (the lower part of Gaussian is rather flat).
    %Should be OK
%3: transfer back to sampled Gaussian to Eta_d
Eta_d = zeros(size(Lower));
GLower = zeros(size(Lower));
GUpper = zeros(size(Upper));

%transfer bound

for i=1:size(GLower,1)
%     Lower(i)
    F = TruncECdf(NPNEta(:,i),Lower(i));
    GLower(i) = norminv(F);
    GUpper(i) = norminv(TruncECdf(NPNEta(:,i),Upper(i)));     

end

%rejection sampling the Gaussnian \times I(A)
% MaxV = mvnpdf(mu,mu,Sigma);   
%using the maximum of normal for now. A better upper bound is to calculate
%the maximum of mvnpdf in the bound, but it is too costy (solve a quadratic
%programing).
%this maximum's rejection rate is way tooo high.
%have to solve the qp in each step = =
% tic;
% fprintf('solve qp for maximum\n');
MaxV = FindBoundedMaximum(mu,Sigma,GLower,GUpper);
% toc

SampleRound = 10000;

SumRej = 0;
for ite=1:SampleRound
    X = unifrnd(GLower,GUpper);
    PdfValue = mvnpdf(X,mu,Sigma);    
    SumRej = SumRej + PdfValue / MaxV;
    y = unifrnd(0,MaxV);
%     fprintf('target pdf [%f]-[%f/%f] rejection rate = [%f]\n',y,PdfValue,MaxV, PdfValue/MaxV);
    if y < PdfValue
%         fprintf('get sample in [%d] round [%f] rate\n',i,PdfValue / MaxV);

        break
    end
end



for i=1:size(X,1)
    Eta_d(i) = TruncInvECdf(NPNEta(:,i),normcdf(X(i)));
end



