function F=filter_proposed(X,N,b1,b2)
noise_density=(numel(find(N==1))/numel(N));
alpha=((b1+255-b2)/255);
mu=(1-noise_density);                
out=X;
win=1;
new_noise=N;
[row,col]=size(X);
count=Inf;
if(noise_density<=0.2)
    w_max=3;
elseif(noise_density<=0.4 && noise_density>0.2)
    w_max=5;
else
    w_max=7;
end

while(count~=0)
    win=win+2;
    xtend_X=wextend('2D','sym',X,ceil(win/2)-1);
    xtend_noise=wextend('2D','sym',new_noise,ceil(win/2)-1);
    count=0;
    for i=1:row
        for j=1:col
            if(N(i,j)==1)
                wk=zeros(win);
                bk=zeros(win);
                for x=1:win
                    for y=1:win
                        wk(x,y)=xtend_X(i+x-ceil(win/2)+ceil(win/2)-1,j+y-ceil(win/2)+ceil(win/2)-1);
                        bk(x,y)=xtend_noise(i+x-ceil(win/2)+ceil(win/2)-1,j+y-ceil(win/2)+ceil(win/2)-1);
                    end
                end          
                vec=find(bk~=1);
                if((length(vec)>=((0.5*(win^2)*mu))|| (win>w_max && numel(vec)~=0)))
                    out(i,j)=mask_create(wk,bk,alpha);
                    N(i,j)=0;
                else
                    count=count+1;
                end
            end
        end
        h=waitbar(i/row);
    end
   % [count win]
end
close(h);
F=uint8(out);

function F=mask_create(wk,bk,alpha)
mask=zeros(size(bk));
mask(find(bk==0))=1;
bk=mask;
win=size(mask,1);
k=(win-1)/2;
[~,~,gk]=gaussian_fun(k);
gwk=round((gk.*bk)*(2*k+1));
vec=[];
for i=1:numel(gwk)
    for j=1:gwk(i)
        vec=[vec wk(i)];
    end
end
md=median(vec);
mn=sum(sum((gk.*bk.*wk)/sum(sum(gk.*bk))));
F=(alpha*md)+(mn*(1-alpha));
% wk
% bk
% gk
% gwk
% alpha
% md
% mn
% F
% pause