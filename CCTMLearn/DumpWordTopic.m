function [ flag ] = DumpWordTopic(Words,Phi,OutName)
%put word topic prob into OutName

out = fopen(OutName,'w');
for i=1:size(Words,1)
    fprintf(out,'%s\t',Words{i});
    fprintf(out,'%f\t',Phi(:,i));
    fprintf(out,'\n');
end
flag = 1;
fclose(out);

