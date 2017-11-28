%Main  Routine for single object tracker
% CS696, homework assignment 6: tracking a single object over time
% Input: a short sequence of images of an object (e.g. mug);  an initial box of the object in the first image; 
% Output: object boxes in all the images.

% Assumption: only translation deformation over the bounding box ( you
% might consider the other deformations, e.g. scale, shear, rotation, or
% affine, see Lecture_10_ransac_II.


%% global variables
strDirName='seq1'; % name of sequence
%strDirName='seq2'; 

% load groundtruth box; 
load([strDirName '.mat'],'gd'); 

%all images;
D=dir([strDirName '/*.jpg']);
% generate demo video; 
bOutputVideo=true;
% Each box is described with a rectangle  [xmin ymin width height] 
arrRect=zeros(4,length(D)); % box sequence to solve

%% Get the initial box from the first image
%initial box, form groundtruth annotation
startBox=gd{1};

%first image
I=imread([strDirName '/' D(1).name ]);
total=0;
%visualize the initial box;
figure(1), 
imshow(I), hold on;
gx=startBox(:,1);
gy=startBox(:,2);
plot([gx(1) gx(2) gx(2) gx(1) gx(1)],[gy(1) gy(1) gy(2) gy(2) gy(1)],'.-','LineWidth',5, 'Color','g');
title('initial box');

 
%initialize
box1=gd{1};
%convert groundtruth to the rectangle format [xmin ymin width height] 
arrRect(:,1)=[box1(1,1) box1(1,2) box1(2,1)-box1(1,1) box1(2,2)-box1(1,2)];

%% For every the other image, use the following scripts to track object at time t
% step 1: according to the bounding-box at time t-1 (or the first image), crop image objects 
% from the images t-1 and t. 
% step 2: detect interest points in both of the two  cropped images; 
% step 3: extract features for every interest point and find the
% correspondences between two cropped images; 
% step 4: estimate translation displacement (your own code)
% step 5: calculate tracking error: euclidean distance between the predicted central
%point and ground-truth central point (your own code)
% step 6: write images overlaid with boxes in video sequence. Set
% bOutputVideo to be true;

if bOutputVideo
    vHandle = VideoWriter([strDirName '_results.avi']);
    open(vHandle);
end
% for every the other image, estimate the bounding box 
for i=2:length(D)
    % current image
    I=imread([strDirName '/' D(i).name ]);
    % to solve rectCur
    rectCur=zeros(1,4); %rect [xmin ymin width height] 
    
    % previous image    
    %Method 1: use the box at the begining, 
    Ip=imread([strDirName '/' D(1).name ]);
    rectPre=arrRect(:,1); 
    
    %Method 2: use the box at the previous time (t-1)
%     Ip=imread([strDirName '/' D(i-1).name ]); 
%     rectPre=arrRect(:,i-1); % use the box at the previous time (t-1)
    
    %%  step 1: crop images of object
    % crop previous image Ip
    I1=imcrop(Ip,rectPre);    
    % crop the current image I 
    I2=imcrop(I,rectPre);    
    
    % visualize the detected box in the previous
    figure(4), imshow(Ip), hold on;
    gx=[rectPre(1); rectPre(1)+rectPre(3)];
    gy=[rectPre(2); rectPre(2)+rectPre(4)];     
    plot([gx(1) gx(2) gx(2) gx(1) gx(1)],[gy(1) gy(1) gy(2) gy(2) gy(1)],'.-','LineWidth',5, 'Color','b');
    title('detected box');
    title('previous image');
    
    
    %Resize the cropped images and apply Gaussian filtering
    sfactor=5.0;
    I1=rgb2gray(imresize(I1,sfactor));
    I2=rgb2gray(imresize(I2,sfactor));
    % Gaussian filtering
    sigma=5;
    I1 = imgaussfilt(I1,sigma);
    I2 = imgaussfilt(I2,sigma);
    
    %% step 2: detect interest points, i.e., corners.
    points1 = detectHarrisFeatures(I1);
    points2 = detectHarrisFeatures(I2);
    
    %% step 3: extract featurs and Match the features.    
    [features1,valid_points1] = extractFeatures(I1,points1);
    [features2,valid_points2] = extractFeatures(I2,points2);    
    indexPairs = matchFeatures(features1,features2);       
   
    % Retrieve the locations of the corresponding points for each image.
    matchedPoints1 = valid_points1(indexPairs(:,1),:);
    matchedPoints2 = valid_points2(indexPairs(:,2),:);
   
    
    %Visualize the corresponding points
    figure(2); clf; ax = axes;
    showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage','Parent',ax);
    
    % IMPORTANT: re-size the localization of the matched points
    matchedPoints1.Location=matchedPoints1.Location/sfactor;
    matchedPoints2.Location=matchedPoints2.Location/sfactor;
    
    %% step-4: estimate the translation displacement (your own code)
    
    %%%%%%%%%% start of placeholder, use the first pair of matched points to estimate translation
    %translation
             
% least square      
  p1= matchedPoints1.selectStrongest(1);
  p2= matchedPoints2.selectStrongest(1);
  % window size
  size=6;
  %crop around the strongest match point
  w1=Ip(ceil(p1.Location(1,1))-size/2:ceil(p1.Location(1,1))+size/2,ceil(p1.Location(1,2))-size/2:ceil(p1.Location(1,2))+size/2);
  w2=I(ceil(p2.Location(1,1))-size/2:ceil(p2.Location(1,1))+size/2,ceil(p2.Location(1,2))-size/2:ceil(p2.Location(1,2))+size/2);
  %x and y axis derivative 
  I_x=imfilter(w1,[1 0 -1]);
  I_y=imfilter(w1,[1; 0; -1]);
  A=double([reshape(I_x,[],1) reshape(I_y,[],1)]);
  b=double(reshape(w1-w2,[],1));
  %least square
  vecT=((A'*A)^-1)*A'*b;
  rectCur(1:2)=rectPre(1:2)-vecT; 


% %RANSAC
%     p1=matchedPoints1.Location; 
%     p2=matchedPoints2.Location; 
%    % max iteration   
%     iter=50; 
%    % total number of points
%     number=size(p1,1);
%     error=zeros(number,iter);
%     % random choose one point
%     p=2; 
%    for j=1:iter
%        index=randperm(number);
%        ind(j,:)=index(1:p);
%        x1=p1(index(1:p),:); 
%        x2=p2(index(1:p),:);    
%        vecT=inv(x1'*x1)*x1'*x2;
%        % parameters for best fitting line
%        diff=p1*vecT; 
%        % compute the distances between all points with the fitting line 
%        error(:,j)=sqrt(sum((p2-diff).^2,2));
%    end
%        errorf=median(error);
%        %select the best fitting
%        k=find(errorf==min(errorf));
%        index(1:p)=ind(k(1),:);
%        x1=p1(index(1:p),:); 
%        x2=p2(index(1:p),:); 
%        vecT=inv(x1'*x1)*x1'*x2;
%        rectCur(1:2)=rectPre(1:2)-vecT(2,:)'; 
  
 
%    vecT=matchedPoints1.Location(1,:)-matchedPoints2.Location(1,:);
%    rectCur(1:2)=rectPre(1:2)-vecT';
    rectCur(3:4)=rectPre(3:4); % no scale change over time in this assignment
    %%%%%%%%%% end of placeholder 
    
    % output variables
    arrRect(:,i)=rectCur;
    
    %visualize the new box
    figure(3); clf;
    imshow(I), hold on; 
    gx=[rectCur(1); rectCur(1)+rectCur(3)];
    gy=[rectCur(2); rectCur(2)+rectCur(4)];     
    plot([gx(1) gx(2) gx(2) gx(1) gx(1)],[gy(1) gy(1) gy(2) gy(2) gy(1)],'.-','LineWidth',5, 'Color','r');
    title('detected box');
    
    
    % visualize the groundtruth box
    
    boxGD=gd{i};
	rectGD=[boxGD(1,1) boxGD(1,2) boxGD(2,1)-boxGD(1,1) boxGD(2,2)-boxGD(1,2)];
    gx=[rectGD(1); rectGD(1)+rectGD(3)];
    gy=[rectGD(2); rectGD(2)+rectGD(4)];     
   % plot([gx(1) gx(2) gx(2) gx(1) gx(1)],[gy(1) gy(1) gy(2) gy(2) gy(1)],'.-','LineWidth',5, 'Color','g');
    %title('groundtruth box');
    
     %% step-5: Calculate tracking error: euclidean distance between the predicted box and ground-truth box
    
     dist = pdist2(rectCur(1:2)+rectCur(3:4)/2, rectGD(1:2)+rectGD(3:4)/2, 'euclidean');
     total=total+dist;
     fprintf('error: %f\n',dist);
     fprintf('error: %f\n',  total);
     % euclidean distance between rectCur and rectGD
     
     %% step-6: 
     if bOutputVideo
         disp('dump result...');
         frame = getframe;
         writeVideo(vHandle,frame);
     end
 disp(i);
 pause(1/20);   
end

avg=total/50;
fprintf('avg: %f\n',  avg);
%dump image sequences
if bOutputVideo
close(vHandle);
end







