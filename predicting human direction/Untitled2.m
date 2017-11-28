accuracy=zeros(1,10);
x={4,6,8,10,12,14,16,20,24,32};
for ii=1:10
cellsize=ii;
switch ii
   case 1
   featureSize =128; 
   cellsize=4;
   case 2
  featureSize =288; 
    cellsize=6;
    case 3
    featureSize =512; 
    cellsize=8;
    case 4
   featureSize =800; 
    cellsize=10;
    case 5
    featureSize =1152; 
    cellsize=12;
    case 6
    featureSize =1568; 
    cellsize=14;
    case 7
    featureSize =512; 
    cellsize=16;
    case 8
    featureSize =800; 
    cellsize=20;
    case 9
    featureSize =768; 
    cellsize=24;
    case 10
    featureSize =512; 
    cellsize=32;
   end