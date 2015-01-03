function Phi = RecoverWordTopicProb(lZ,beta)
%recover from last samples
%beta: dir prior
%size(lZ,3) is number of sample
%Phi is |V * k| prob matrix
[~,V,SampleSize] = size(LZ);
k = max(max(max(lZ)));
WordTopicCnt = ones(V,k) * beta;
for i=1:SampleSize
    WordTopicCnt = WordTopicCnt + CountWordTopic(lZ(:,:,i));
end

Phi = (WordTopicCnt ./ (ones(V,1) * sum(WordTopicCnt,1)))';







