function [ Eta] = SampleEta(mu,Sigma,NPNEta, LastZ,LastEta)
%one round sample from posterior of Eta.
%NPNEta is the input parameter for the whole sampling process
%LastEta is the last round's sample result (D \times k)
%Z is the current sampled Z
%eta is for all doc, thus |D \times k|

%will call SampleBound(Z,LastEta) for Eta's lower and upper bound
%call SampleNPN(mu,Sigma,NPNEta) for sampling from NPN()

fprintf('sampling Eta\n');
[LowerEta,UpperEta] = SampleBound(LastZ,LastEta);
[m,k] = size(LastEta);
Eta = LastEta;

% fprintf('sample from NPN within bound\n');
tic;
parfor i=1:m

%     fprintf('start sample for [%d] doc\n',i);
%     fprintf('bound\n');
%     for mid=1:size(LowerEta,2)
%        fprintf('%f - %f\n',LowerEta(i,mid),UpperEta(i,mid));
%     end
    Eta(i,:) = SampleBoundedNPN(mu,Sigma,NPNEta,LowerEta(i,:)',UpperEta(i,:)')';
%     for j = 1:NumOfSample
%         TestEta = NPN(mu,Sigma,NPNEta);
%         if (sum(TestEta < LowerEta(i,:)') + sum(TestEta > UpperEta(i,:)')) ~= 0
% %             fprintf('[%d] sample exceeds bound\n',j);
%             continue
%         end
%         Eta(i,:) = TestEta';
%         fprintf('[%d] sample success\n',j);
%         flag = 0;
%         break;
%     end
%     if flag
%        fprintf('not able to sample for doc [%d] in [%d] repeat\n',i,NumOfSample); 
%     end            
%     fprintf('[%d/%d] doc sampled\n',i,m);
end 
toc
% fprintf('Eta of all doc sampled\n');

