function out=noise_model(S,salt,pepper,p1,p2)
rng_1=salt(2)-salt(1);
rng_2=pepper(2)-pepper(1);

if rng_1==0 
    rng_1=1;
end

if rng_2==0
    rng_2=1;
end

[M,N] = size(S);
r(1:M,1:N) = 0.5;
X = rand(M,N);
c = find(X<=p1);
r(c) = 0;
u = p1 + p2;
c = find(X > p1 & X <= u);
r(c) = 1;

c = find(r == 1);
gp = S;
if rng_2~=1
    gp(c) = round(rand(1,length(c))*rng_2)+pepper(1);
else
    gp(c) = ceil(rand(1,length(c))*rng_2)+pepper(1);
end


c = find(r == 0);
if rng_1~=1
    gp(c) = round(rand(1,length(c))*rng_1)+salt(1);
else
    gp(c) = floor(rand(1,length(c))*rng_1)+salt(1);
end

out=gp;