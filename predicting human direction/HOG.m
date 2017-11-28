function [features] =HOG(image,cellsize)
  image=imresize(image, [256 256]);
  features = extractHOGFeatures(image, 'CellSize', [cellsize cellsize]);


