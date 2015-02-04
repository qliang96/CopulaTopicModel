function Phi = RecoverWordTopicProb(lZ,beta,V,k)
%recover from last samples
%beta: dir prior
%size(lZ,3) is number of sample
%Phi is |V * k| prob matrix

SampleSize = size(lZ,1);
WordTopicCnt = ones(V,k) * beta;
for i=1:SampleSize
    WordTopicCnt = WordTopicCnt + CountWordTopic(lZ{i},V,k);
end

Phi = (WordTopicCnt ./ (ones(V,1) * sum(WordTopicCnt,1)))';







