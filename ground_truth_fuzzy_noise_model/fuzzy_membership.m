function ft=fuzzy_membership(u)
ft=[];
for t=1:2*u+1
    ft=[ft u-abs(u-(t-1))];
end
