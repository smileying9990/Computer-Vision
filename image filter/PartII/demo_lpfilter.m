I=imread('cat.bmp');
%Convert to grayscale
I=rgb2gray(I); 
subplot(2,2,1), imshow(I)

%Determine good padding for Fourier transform
PQ = paddedsize(size(I));

%Create a Gaussian Lowpass filter 5% the width of the Fourier transform
%D0 = 0.05*PQ(1);
D0 = 0.07*PQ(1);
%D0 = 0.01*PQ(1);
H = lpfilter('gaussian', PQ(1), PQ(2), D0);

% Calculate the discrete Fourier transform of the image
F=fft2(double(I),size(H,1),size(H,2));

% Apply the highpass filter to the Fourier spectrum of the image
LPFS_I = H.*F;

% convert the result to the spacial domain.
LPF_I=real(ifft2(LPFS_I)); 

% Crop the image to undo padding
LPF_I=LPF_I(1:size(I,1), 1:size(I,2));

%Display the blurred image
subplot(2,2,2), imshow(LPF_I, [])

% Display the Fourier Spectrum 
% Move the origin of the transform to the center of the frequency rectangle.
Fc=fftshift(F);
Fcf=fftshift(LPFS_I);
% use abs to compute the magnitude and use log to brighten display
S1=log(1+abs(Fc)); 
S2=log(1+abs(Fcf));
subplot(2,2,3), imshow(S1,[])
subplot(2,2,4), imshow(S2,[])