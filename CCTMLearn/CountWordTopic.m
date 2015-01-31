function [WordTopicCnt ] = CountWordTopic(Z,V,k)
%count the occur of word -topic matrix
WordTopicCnt = zeros(V,k);
for i=1:k
    WordTopicCnt(:,i) = sum((Z == i),1)';
end


