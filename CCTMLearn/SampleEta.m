function [ Eta] = SampleEta(mu,Sigma,NPNEta, LastZ,LastEta)
%one round sample from posterior of Eta.
%NPNEta is the input parameter for the whole sampling process
%LastEta is the last round's sample result (D \times k)
%Z is the current sampled Z
%eta is for all doc, thus |D \times k|

%will call SampleBound(Z,LastEta) for Eta's lower and upper bound
%call SampleNPN(mu,Sigma,NPNEta) for sampling from NPN()

fprintf('start sample Eta for all doc\n');
[LowerEta,UpperEta] = SampleBound(LastZ,LastEta);
[m,k] = size(LastEta);
Eta = LastEta;
NumOfSample = 1000;
for i=1:m
    flag = 1;
    for j = 1:NumOfSample
        TestEta = NPN(mu,Sigma,NPNEta);
        if (sum(TestEta < LowerEta(i,:)') + sum(TestEta > UpperEta(i,:)')) ~= 0
            continue
        end
        Eta(i,:) = TestEta';
        flag = 0;
        break;
    end
    if flag
       fprintf('not able to sample for doc [%d] in [%d] repeat\n',i,NumOfSample); 
    end            
end 
fprintf('Eta of all doc sampled\n');

