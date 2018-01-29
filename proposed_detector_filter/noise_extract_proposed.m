function [N,N1,N2,nh,nhd,b1,b2]=noise_extract_proposed(X,ft)
b=double(X);
k=10;
win=2*k+1;
[row,col]=size(b);
c11=wextend('2D','sym',b,(win-1)/2);
o=zeros(row,col);
%st=0;%only for histogram display 1-yes 0-no
for i=1:row
    for j=1:col
        w=zeros(win);
        for x=1:win
            for y=1:win
                w(x,y)=c11(i+x-1,j+y-1);
            end
        end
        [a,b]=hist_eq_boundary_new(w,ft);
        if(w(ceil(win/2),ceil(win/2))<a || w(ceil(win/2),ceil(win/2))>b)
           o(i,j)=1;
        else
           o(i,j)=0;           
        end
    end
    h=waitbar(i/row);
end
close(h);
N=o;
X_pixel_intensity=X(find(N==1));
nh=imhist(X_pixel_intensity);
nhd=[0 nh(3:end)'-nh(1:end-2)'];
[~,low]=min(nhd(1:127));
[~,high]=max(nhd(end:-1:128));
b1=max([low(1) high(1)]);
b2=255-b1;
N1=N;
N=zeros(size(X));
N(union(find((X<=b1)),find((X>=b2))))=1;
N2=N;
N=zeros(size(X));
N_loc=intersect((find(N1==1)),(find(N2==1)));
N(N_loc)=1;
end

function [a,b]=hist_eq_boundary_new(w,fuz)
h=hist(w(:),255);
hh=conv(h,fuz,'same');
m=round(median(unique(w(:))));
[~,a]=sort(hh(1:m));
[~,b]=sort(hh(255:-1:m));
if(hh(a(1))==0 && hh(255-b(1))==0)
    a=a(1);b=255-b(1);
elseif(hh(a(1))~=0 && hh(255-b(1))~=0)
    [a,b]=find_ab(w(10:12,10:12));
elseif(hh(a(1))~=0 || hh(255-b(1))==0)
    a=b(1);b=255-a;
elseif(hh(a(1))==0 || hh(255-b(1))~=0)
    a=a(1);b=255-a;
end
%st=getGlobalst;
st=0;
if(st==1)
    figure(1);set(gcf,'color','white');h1=plot(h,'color',[0 1 0],'LineWidth',4);
    hold on;h2=plot(hh,'color',[0 0 1],'LineWidth',4);
    axis([1 255 1 max(hh)+10]);   
    h3=stem([a],ones(1,1)*max(hh)/2,'color',[1 0 0],'LineWidth',4);
    h4=stem([b],ones(1,1)*max(hh)/2,'color',[1 1 0],'LineWidth',4);
    legend([h1 h2 h3 h4],'Histogram','Fuzzy Histogram','a','b');
    xlabel('Gray level Intensity (i)');
    ylabel('HIstogram h(i)');
    hold off;
    pause(0.0001);
end
end

function [a,b]=find_ab(w)
data_vec=w(:)';
data_sort=sort(data_vec);
vd=[abs(data_sort(2:end)-data_sort(1:end-1))];
aa=max(vd(find(data_sort<median(data_sort))));
if(numel(aa)==0)
    a=median(data_sort);
else
    a=find(vd==aa);
    a=data_sort(a(1)+1);
end
locs=find(data_sort>=median(data_sort));
bb=max(vd(locs(1:end-1)));
if(numel(bb)==0)
    b=median(data_sort);
else
    b=find(vd==bb);
    b=data_sort(b(end));
end
end
