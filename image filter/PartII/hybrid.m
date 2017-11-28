
I = rgb2gray(imread('data/cat.bmp'));
I1= rgb2gray(imread('data/dog.bmp'));
% enter filter type and low-pass thresholds
LPFS_I= my_filter(I,'btw',0.03,0);
LPFS_I1= my_filter(I1,'btw',0.03,1);
hybrid_image=LPFS_I+LPFS_I1;
Fh=fftshift(hybrid_image);
Sh=log(1+abs(Fh)); 
figure(3),subplot(1,2,1),imshow(Sh,[]);
hybrid_image=real(ifft2(hybrid_image)); 
hybrid_image=hybrid_image(1:size(I,1), 1:size(I,2));
figure(3),subplot(1,2,2),imshow(hybrid_image,[]);









