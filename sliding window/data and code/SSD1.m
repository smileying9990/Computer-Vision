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
img=double(rgb2gray(img));
mask=double(rgb2gray(template));
[m n]=size(img);
H=res+1;
image1=padarray(img,[H/2 H/2],'both');
re=zeros(m,n);
for i=1:m
    for j=1:n
        tmp=image1(i:i+H-1,j:j+H-1);
        re(i,j)=sum(sum((tmp-mask).^2));       
    end
end

re=mat2gray(re);
% calculate the estimated location
m=min(min(re));
[x,y]=find(m==re);
imshow(1-re);title('SSD1 matching');imwrite(1-re,'1.jpg');
% calculate the localization error
dis=norm([x,y] -[sx,sy]);

