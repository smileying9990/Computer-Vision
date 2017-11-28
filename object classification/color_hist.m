function [hisc] = color_hist(img)
[x,y,z]=size(img);
I=reshape(img,x*y,z);  % r,g,b per column
I=double(I);
c=hist(I,[0:2:255]);
hisc=sum(c,2);

% below is for grey scale input image
%[x,y]=size(img);
%I=reshape(img,x*y,1);
%I=double(I);
%hisc=hist(I,[0:2:255]);












