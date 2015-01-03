function [ Z,Eta ] = GibbsSample(W,beta,mu,Sigma,NPNEta)
%gibbs sample from W,beta,mu,Sigma,Eta
%return the expectated Z,Eta from posterior distribution
    % using empirical mean from burned in samples
%need to defind the burn in status

%calls form SampleZ(), SampleEta() each iteraton to gibbs sample Z and Eta
%maintain a que of Z and Eta, with given size of samples S, each time update
%it. not check burn in for first S samples

%check burned in for each S sample, if the mean is similar with mean of S
%times before, it is burned in.

DiscardFirstN = 100;
k = size(mu,1);
[M,V] = size(W);
SampleSize = 100;
%init
Z = randi([1,k],M,V) .* W;
Eta = NPNEta;
lZ = zeros(size(Z,1),size(Z,2),SampleSize);
lEta = zeros(size(Eta,1),size(Eta,2),SampleSize);
LastMeanZ = Z;
LastMeanEta = Eta;

for ite=1:5000
    Z = SampleZ(beta,W,Z,Eta);
    Eta = SampleEta(mu,Sigma,NPNEta, Z,Eta);
    p = ite - DiscardFirstN;
    if p <= 0
        continue
    end
    
    lZ(:,:,mod(p, SampleSize)) = Z;
    lEta(:,:,mod(p,SampleSize)) = Eta;
    
    if mod(p,SampleSize) == 0
        %check burn-in in each sample size step.
       ThisMeanZ = mean(lZ,3);
       ThisMeanEta = mean(lEta,3);
       
       %check burn in
       ZDiff = sum(sum(abs(ThisMeanZ - LastMeanZ))) / sum(sum(LastMeanZ));
       EtaDiff = sum(sum(abs(ThisMeanEta - LastMeanEta))) / sum(sum(LastMeanEta));
       fprintf('%d ite, z diff [%f], Eta diff [%f]\n',ite,ZDiff,EtaDiff);
       if  ZDiff + EtaDiff < 1.0 / SampleSize
           fprintf('burned in at [%d] ite\n',ite);
           %Z = ThisMeanZ;
           %Eta = ThisMeanEta;
           break       
       else
           LastMeanZ = ThisMeanZ;
           LastMeanEta = ThisMeanEta;                   
       end       
    end
end
