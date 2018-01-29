function [w,h,hf,a1,a2,status,pixel_st]=noise_extract_proposed_check(X,row,col,ft)
b=double(X);
k=10;
win=2*k+1;
c11=wextend('2D','sym',b,(win-1)/2);
for i=row
    for j=col
        w=zeros(win);
        for x=1:win
            for y=1:win
                w(x,y)=c11(i+x-1,j+y-1);
            end
        end
        [h,hf,a1,a2,status]=hist_eq_boundary_new(w,ft);
        if(w(ceil(win/2),ceil(win/2))<a1 || w(ceil(win/2),ceil(win/2))>a2)
           pixel_st=1;
        else
           pixel_st=0;           
        end
    end
end
end
function [h,hf,a1,a2,status]=hist_eq_boundary_new(w,fuz)
h=hist(w(:),255);
hf=conv(h,fuz,'same');
m=round(median(unique(w(:))));
[~,a1]=sort(hf(1:m));
[~,a2]=sort(hf(255:-1:m));
if(hf(a1(1))==0 && hf(255-a2(1))==0)
    a1=a1(1);a2=255-a2(1);status=1;
elseif(hf(a1(1))~=0 && hf(255-a2(1))~=0)
    [a1,a2]=find_a1_a2(w(10:12,10:12));status=2;
elseif(hf(a1(1))~=0 && hf(255-a2(1))==0)
    a1=a2(1);a2=255-a1;status=3;
elseif(hf(a1(1))==0 && hf(255-a2(1))~=0)
    a1=a1(1);a2=255-a1;status=4;
end
%st=getGlobalst;
st=0;
if(st==1)
    figure(1);set(gcf,'color','white');h1=plot(h,'color',[0 1 0],'LineWidth',4);
    hold on;h2=plot(hf,'color',[0 0 1],'LineWidth',4);
    axis([1 255 1 max(hf)+10]);   
    h3=stem([a1],ones(1,1)*max(hf)/2,'color',[1 0 0],'LineWidth',4);
    h4=stem([a2],ones(1,1)*max(hf)/2,'color',[1 1 0],'LineWidth',4);
    legend([h1 h2 h3 h4],'Histogram','Fuzzy Histogram','a1','a2');
    xlabel('Gray level Intensity (i)');
    ylabel('HIstogram h(i)');
    hold off;
    pause(0.0001);
end
end

function [a1,a2]=find_a1_a2(w)
data_vec=w(:)';
data_sort=sort(data_vec);
vd=[abs(data_sort(2:end)-data_sort(1:end-1))];
aa=max(vd(find(data_sort<median(data_sort))));
if(numel(aa)==0)
    a1=median(data_sort);
else
    a1=find(vd==aa);
    a1=data_sort(a1(1)+1);
end
locs=find(data_sort>=median(data_sort));
bb=max(vd(locs(1:end-1)));
if(numel(bb)==0)
    a2=median(data_sort);
else
    a2=find(vd==bb);
    a2=data_sort(a2(end));
end
a1=a1(1);
a2=a2(1);
end
