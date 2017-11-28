img=imread('image3.jpg');
%determine template size
res=29;
d=floor(res/2);
%determine ground-truth location 
%sx=520;
%sy=476;
%sx=113;
%sy=118;
sx=82;
sy=90;
% crop template
im_template=img(sx-d:sx+d+1,sy-d:sy+d+1,:);
figure(1),imshow(im_template);imwrite(im_template,'1.jpg');
% convert image to grayand double precision
img = rgb2gray(img);
im_template = rgb2gray(im_template);
img1 =double(img);
dim_template = double(im_template);

[m n]=size(img);
H=res+1;

img1=padarray(img1,[H/2 H/2],'both');
re=zeros(m,n);
for i=1:m
    for j=1:n
        tmp=img1(i:i+H-1,j:j+H-1);
        %zero mean correction
        tmp1=mean2(tmp);
        avg_tmp=tmp-tmp1;
        re(i,j)=sum(sum(avg_tmp.*dim_template));       
    end
end

% calculate the estimated location
A=max(max(re));
[row, col]=find(A==re);
re=mat2gray(re);
figure(2),imshow(re);title('MEAN1 matching');imwrite(re,'2.jpg');
% calculate the localization error
dis=norm([row, col] -[sx,sy]);




