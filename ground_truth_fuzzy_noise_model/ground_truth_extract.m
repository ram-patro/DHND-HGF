function M=ground_truth_extract(S,X)
M=zeros(size(S));
for i=1:numel(S)
    if(S(i)==X(i))
        M(i)=0;
    else
        M(i)=1;
    end
end