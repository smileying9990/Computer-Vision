function [features] =HOG(image,cellsize)
	%points = detectHarrisFeatures(image);
	[x,y] = size (image);
	features = extractHOGFeatures(image,'blocksize',[cellsize cellsize],'cellsize',[floor(x/cellsize), floor(y/cellsize)],'NumBins',8);
