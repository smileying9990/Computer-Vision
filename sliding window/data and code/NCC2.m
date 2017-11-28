img=imread('image1.jpg');
%determine template size
res=29;
d=floor(res/2);
%determine ground-truth location 
sx=113;
sy=118;
% crop template
template=img(sx-d:sx+d+1,sy-d:sy+d+1,:);
scale_factor =2;     %choose between 0.5,1,2...
% convert image to gray
gtemplate= rgb2gray(template);  
%convert to double precision
dtemplate =double(gtemplate);   
 %construct gaussian filter
cutoff_frequency=1;
G=fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
gauss_level_0 = imfilter(dtemplate, G);
B = imresize(gauss_level_0 , scale_factor, 'bilinear');
A=double(rgb2gray(img));
%NCC
normx_corrmap=normxcorr2(B,A);
imshow(normx_corrmap);title('NCC2 matching');imwrite(normx_corrmap,'2.jpg');
% calculate the estimated location
maxptx = max(max(normx_corrmap));
[x1,y1]=find(normx_corrmap==maxptx);
% calculate the localization error
dis=norm([x1, y1] -[sx+floor(res/2),sy+floor(res/2)]);
