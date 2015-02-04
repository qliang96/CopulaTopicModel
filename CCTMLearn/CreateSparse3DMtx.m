function [ M ] = CreateSparse3DMtx( a,b,c)
%create a sparse 3 d mtx., a,b is mtx dim, c is the index of sparse mtx
M=cell(c,1);
for i=1:c
    M{i}=sparse(a,b);
end

