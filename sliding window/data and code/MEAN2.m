
im_matched=imread('image1.jpg');
%determine template size
res=29;
d=floor(res/2);
%determine ground-truth location 
sx=113;
sy=118;
% crop template
rect=[sx-d sy-d res res];
im_template=imcrop(im_matched,rect);
%im_template=im_matched(sx-d:sx+d+1,sy-d:sy+d+1,:);
scale_factor =1;     %choose between 0.5,1,2...
gtemplate= rgb2gray(im_template);    % convert image to gray
dtemplate =double(gtemplate);       %convert to double precision
 %construct gaussian filter
cutoff_frequency=1;         
G=fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
%convolute original template image with gaussian filter 
gauss_level_0 = imfilter(dtemplate, G);
%resize template image
dim_template = imresize(gauss_level_0 , scale_factor, 'bilinear');
figure(1),subplot(1,2,1);imshow(gauss_level_0,[]);
im_matched = rgb2gray(im_matched);
img1 =double(im_matched);
figure(1);imshow(dim_template,[]);title('scale1 template');

[m n]=size(img1);
H=(res+1)*scale_factor;

img1=padarray(img1,[floor(H/2) floor(H/2)],'both');
re=zeros(m,n);
for i=1:m
    for j=1:n
        tmp=img1(i:i+H-1,j:j+H-1);
        tmp1=mean2(tmp);
        avg_tmp=tmp-tmp1;
        re(i,j)=sum(sum(avg_tmp.*dim_template));       
    end
end
% calculate the estimated location
A=max(max(re));
[row, col]=find(A==re);
re=mat2gray(re);
figure(2),imshow(re);title('MEAN2 matching');imwrite(re,'1.jpg');
figure(3),imshow(re>0.6);title('MEAN2 matching');imwrite(re,'1.jpg');
% calculate the localization error
dis=norm([row, col] -[sx,sy]);