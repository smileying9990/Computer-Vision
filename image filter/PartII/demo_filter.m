f = rgb2gray(imread('cat.bmp'));
[m,n]=size(f);
h = fspecial('sobel');

F = fft2(double(f),m,n);
H = fft2(double(h),m,n);

F_fH = H.*F;
ffi = ifft2(F_fH);
%ffi = ffi(2:size(f,1)+1, 2:size(f,2)+1);

%Display results (show all values)
figure, imshow(ffi,[])

%The abs function gets correct magnitude
%when used on complex numbers
ffim = abs(ffi);
figure, imshow(ffim, []);
 %  Palm fourier-based edge directions

%threshold into a binary image
figure, imshow(ffim > 0.2*max(ffim(:)));
