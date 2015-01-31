function [ MeanM] = MeanOfSparse3DMtx( M )
%the mean of a sparse mtx

Sum=M{1};
for i=2:size(M,1)
    Sum = Sum + M{i};
end
MeanM = Sum / size(M,1);

