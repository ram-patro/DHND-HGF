function [X,Y,gk]=gaussian_fun(k)
kd=1:2*k+1;
x=kd-(k+1);
y=x;
[X,Y]=meshgrid(x,y);
gk=exp(((k+1)/4)*((-X.^2-Y.^2)/k^2));



