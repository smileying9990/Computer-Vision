img=imread('image3.jpg');
%determine template size
res=29;
d=floor(res/2);
%determine ground-truth location 
sx=82;
sy=90;
% crop template
%rect=[sx-d sy-d res res];
%template=imcrop(img,rect);
template=img(sx-d:sx+d+1,sy-d:sy+d+1,:);
% convert image to grayand double precision
A=double(rgb2gray(img));
B=double(rgb2gray(template));

normx_corrmap=normxcorr2(B,A);
imshow(normx_corrmap);title('NCC1 matching');imwrite(normx_corrmap,'1.jpg');
% calculate the estimated location
maxptx = max(max(normx_corrmap));
[x1,y1]=find(normx_corrmap==maxptx);
% calculate the localization error
dis=norm([x1, y1] -[sx,sy]);
