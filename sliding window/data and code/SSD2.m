img=imread('image1.jpg');
%determine template size
res=29;
%determine ground-truth location 
sx=113;
sy=118;
d=floor(res/2);
% crop template
%rect=[sx-d sy-d res res];
%template=imcrop(img,rect);
template=img(sx-d:sx+d+1,sy-d:sy+d+1,:);
scale_factor =2;     %choose between 0.5,1,2...
% get scaled template image by different scale factor
gtemplate= rgb2gray(template);  % convert image to gray
dtemplate =double(gtemplate);
 %construct gaussian filter
cutoff_frequency=1;
G=fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
%convolute original template image with gaussian filter 
gauss_level_0 = imfilter(dtemplate, G);
%resize template image
mask = imresize(gauss_level_0 , scale_factor, 'bilinear');

img=double(rgb2gray(img));
[m n]=size(img);
H=(res+1)*scale_factor;

image1=padarray(img,[floor(H/2) floor(H/2)],'both');
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
ree=1-re;
imshow(ree);title('SSD2 matching');imwrite(ree, '1.jpg');
% calculate the localization error
dis=norm([x, y] -[sx+floor(res/2),sy+floor(res/2)]);
