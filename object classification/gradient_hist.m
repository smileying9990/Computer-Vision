function [hist] = gradient_hist(img)
cellsize = 4;
[x,y] = size (img);
hist = extractHOGFeatures(img,'blocksize',[cellsize cellsize],'cellsize',[floor(x/cellsize), floor(y/cellsize)],'NumBins',8);