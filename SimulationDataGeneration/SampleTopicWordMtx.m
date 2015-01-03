function Phi = SampleTopicWordMtx(k,V,beta)
%sample from dir(beta) a k*V mtx

a = ones(k,1) * beta;

Phi = gamrnd(repmat(a,V,1),1,V,k);
Phi = Phi ./ repmat(sum(Phi,2),1,k);

end

