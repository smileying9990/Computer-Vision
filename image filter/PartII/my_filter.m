function LPFS_I = my_filter(I,filter,t,flag)
% This function is intended to behave like the built in function imfilter()
% function only work for grey images. 
% filters can be 'ideal', 'btw' ,  'gaussian' 
% flag indicate low-pass filtering or high-pass filtering
%t is Lowpass filter t% the width of the Fourier transform
%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%
PQ = paddedsize(size(I));
D0 = t*PQ(1);
if flag==0
    i=1;
    L = lpfilter(filter, PQ(1), PQ(2), D0);
else
    i=2;
    L = hpfilter(filter, PQ(1), PQ(2), D0);
end
figure(i),subplot(2,2,1), imshow(I); 

% Calculate the discrete Fourier transform of the image
F=fft2(double(I),size(L,1),size(L,2));
% Apply the highpass filter to the Fourier spectrum of the image
LPFS_I = L.*F;
figure(i+3), imshow(F,[]);
LPF_I=real(ifft2(LPFS_I)); 
LPF_I=LPF_I(1:size(I,1), 1:size(I,2));
figure(i),subplot(2,2,2),imshow(LPF_I,[])
Fc=fftshift(F);
Fcf=fftshift(LPFS_I);
% use abs to compute the magnitude and use log to brighten display
S1=log(1+abs(Fc)); 
S2=log(1+abs(Fcf));
figure(i),subplot(2,2,3), imshow(S1,[])
figure(i),subplot(2,2,4), imshow(S2,[])            

  
