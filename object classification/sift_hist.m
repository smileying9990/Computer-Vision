function [hisc] = sift_hist(I)
%I= rgb2gray(read(flowerImageSet(flower), arrTrainID(45)));

I= imresize(I, 0.5, 'bilinear');
corners = detectHarrisFeatures(I);
[~, valid_corners] = extractFeatures(I, corners);
cornerPoints = valid_corners.selectStrongest(150);% set interest points
point= cornerPoints.Location;
x=point(:,1);
y=point(:,2);
x=int32(x);
y=int32(y);

re=get_features(I, x, y, 16);
hisc=sum(re,1);
%hisc=reshape(re,1,10*128);
 





 

 

 