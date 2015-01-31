function [Z] = SampleZ(beta,W,LastZ,LastEta)
%one round of gibbs sampling of Z

%1 get the WordTopicCnt = V \times k matrix, showing each word being
%assigned to k.

%2 for each location in W, calculate topic's multinomial distribution
    %get the count, decide whether need minus 1
    %weight with exp(\eta_k^d)
 %and sample from it
[m,k] = size(LastEta);
V = size(W,2);
WordTopicCnt = CountWordTopic(LastZ,V,k);
TopicCnt = sum(WordTopicCnt,1)';
Z = LastZ;
fprintf('start to sample Z (word-topic) assignment\n');
tic;
for i=1:m
    EtaExp = exp(LastEta(i,:))';
    cnt = 0;
    ColIdx = find(W(i,:));
    for mid=1:size(ColIdx,2)
        j = ColIdx(mid);
%     for j=1:V
%         if W(i,j) == 0
%             continue
%         end
        Wt = Z(i,j);            
        LOOTopicCnt = TopicCnt;
        LOOTopicCnt(Wt) =  LOOTopicCnt(Wt) - 1;
        LOOWordTCnt = WordTopicCnt(j,:)';
        LOOWordTCnt(Wt)  = LOOWordTCnt(Wt) - 1;
        PWordsGivenTopic = (LOOWordTCnt + beta * ones(k,1)) ./...
            (LOOTopicCnt + V * beta * ones(k,1));
        Posterior = PWordsGivenTopic .* EtaExp;
        Posterior = Posterior ./ sum(Posterior);
        NewWt = find(mnrnd(1,Posterior) ~= 0);
        
        %update counts
            %as we are gibbs sampling here
        if NewWt ~= Wt
           TopicCnt(Wt)  = TopicCnt(Wt) - 1;
           TopicCnt(NewWt) = TopicCnt(NewWt) + 1;
           WordTopicCnt(j,Wt) = WordTopicCnt(j,Wt) - 1;
           WordTopicCnt(j,NewWt) = WordTopicCnt(j,NewWt) + 1;
           Z(i,j) = NewWt;
           cnt = cnt + 1;
        end     
        
    end
%     fprintf('[%d/%d] doc sampled [%d/%d] assignment change\n',i,m,cnt,size(ColIdx,2));
end
toc



