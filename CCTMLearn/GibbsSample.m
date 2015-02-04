function [ lZ,lEta ] = GibbsSample(W,beta,mu,Sigma,NPNEta)
%gibbs sample from W,beta,mu,Sigma,Eta
%return the expectated Z,Eta from posterior distribution (last 100 samples)
    % using empirical mean from burned in samples
%need to defind the burn in status

%calls form SampleZ(), SampleEta() each iteraton to gibbs sample Z and Eta
%maintain a que of Z and Eta, with given size of samples S, each time update
%it. not check burn in for first S samples

%check burned in for each S sample, if the mean is similar with mean of S
%times before, it is burned in.

DiscardFirstN = 10;
SampleSize = 50;
MaxIte = 500;

k = size(mu,1);
[M,V] = size(W);

%init
Z = randi([1,k],M,V) .* (W~=0);
Eta = NPNEta;

lZ = CreateSparse3DMtx(size(Z,1),size(Z,2),SampleSize);
lEta = CreateSparse3DMtx(size(Eta,1),size(Eta,2),SampleSize);
LastMeanZ = Z;
LastMeanEta = Eta;
tic

for ite=1:MaxIte
    fprintf('Gibbs sampling [%d] ite\n',ite);
    Z = SampleZ(beta,W,Z,Eta);
    Eta = SampleEta(mu,Sigma,NPNEta, Z,Eta);
    p = ite - DiscardFirstN;
    if p <= 0
        continue
    end

    lZ{mod(p, SampleSize) + 1} = Z;
    lEta{mod(p,SampleSize) + 1} = Eta;
    
    if mod(p,SampleSize) == 0
        %check burn-in in each sample size step.
       ThisMeanZ = MeanOfSparse3DMtx(lZ);
       ThisMeanEta = MeanOfSparse3DMtx(lEta);
       
       %check burn in
       ZDiff = sum(sum(abs(ThisMeanZ - LastMeanZ))) / sum(sum(LastMeanZ));
       ZDiff = full(ZDiff);
       EtaDiff = sum(sum(abs(ThisMeanEta - LastMeanEta))) / sum(sum(LastMeanEta));
       fprintf('\n%d ite, z diff [%f], Eta diff [%f]\n\n',ite,ZDiff,EtaDiff);
       toc
       if  ZDiff + EtaDiff < 0.1
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



