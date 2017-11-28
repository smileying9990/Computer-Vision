% This is the starter code for the Homework Assignment 5, CS696: Applied
% Computer Vision

% Object classification is an important task in many computer vision
% applications, including surveillance, automotive safety, and image
% retrieval. For example, in an automotive safety application, you may need
% to classify nearby objects as pedestrians or vehicles. Regardless of the
% type of object being classified, the basic procedure for creating an
% object classifier is:
% * Acquire a labeled data set with images of the desired object.
% * Partition the data set into a training set and a test set.
% * Train the classifier using features extracted from the training set.
% * Test the classifier using features extracted from the test set.

%To illustrate, this example shows how to classify flower images using
%various features, e.g., histogram, template, or others, and a multiclass SVM
% (Support Vector Machine) classifier. This type of classification is often
% used in many image applications.
%
% The example uses the |fitcecoc| function from the Statistics and Machine
% Learning Toolbox(TM). You should feel free to use any SVM function
% available. 
 

  
% Step-1: Load training and test data using imageSet.
imageDir   = fullfile('./data');

% imageSet recursively scans the directory tree containing the images.
flowerImageSet = imageSet(imageDir,   'recursive');
 


% The flowerImageSet is an array of 3 imageSet objects: one for each flower.
%flowerImageSet(1): for the type 1
%flowerImageSet(2): for the type 2
%flowerImageSet(3): for the type 3

% Show flower examples
figure;
subplot(1,3,1);
imshow(flowerImageSet(1).ImageLocation{1});
subplot(1,3,2);
imshow(flowerImageSet(2).ImageLocation{2});
subplot(1,3,3);
imshow(flowerImageSet(3).ImageLocation{3});

%% step-2: Partition the data set into a training set and a test set.
% in this example, for each flower type, we randomly select 50 images for
% training; and use the other 30 images for testing.

% These randomly generated IDs are shred by all the three flower types. 
 

tmparr=randperm(80);
arrTrainID=tmparr(1:50); %training ID; 
arrTestID=tmparr(51:end);% testing ID;  

 
%% Step-3: Train the classifier using features extracted from the training set.
   
%Image classification is a multiclass classification problem, where you
% have to classify a flower image into one out of the three possible flower classes.

% In this example, the |fitcecoc| function from the Statistics and Machine
% Learning Toolbox(TM) is used to create a multiclass classifier using
% binary SVMs.
%
% Start by features from the training set. These features
% will be used to train the classifier.

% Step 3.1 Extract features from training images

% Loop over the trainingSet and extract features from each image. A
% similar procedure will be used to extract features from the testSet.

trainingFeatures = [];
trainingLabels   = [];
featureSize =128; 
for flower = 1:numel(flowerImageSet)
           
    numImages = numel(arrTrainID);           
    features  = zeros(numImages, featureSize);
    
    for i = 1:numImages
        
         img = rgb2gray(read(flowerImageSet(flower), arrTrainID(i)));
        %img = read(flowerImageSet(flower), arrTrainID(i));
        %PLACEHOLDER#START
        
        features(i, :) = rand(1,featureSize);
       % features(i, :)=gradient_hist(img);
       % features(i, :)=color_hist(img);
       % features(i, :)=sift_hist(img);
        %PLACEHOLDER#END
    end
    
    % Use the imageSet Description as the training labels.  
    labels = repmat(flowerImageSet(flower).Description, numImages, 1);
        
    trainingFeatures = [trainingFeatures; features];  
    trainingLabels   = [trainingLabels;   labels  ];  
        
end

%%
% Step 3.2, train a classifier using the extracted features. 

% fitcecoc uses SVM learners and a 'One-vs-One' encoding scheme.
classifier = fitcecoc(trainingFeatures, trainingLabels);

%% Step 4: Evaluate the Flower Classifier

% Evaluate the flower classifier using images from the test set, and
% generate a confusion matrix to quantify the classifier accuracy.
% 
% As in the training step, first extract features from the test images.
% These features will be used to make predictions using the trained
% classifier. The procedure is similar to what was shown earlier. 

testFeatures=[];
testLabels=[];
% Step 4.1: Loop over the testing images and extract features from each image. 
for flower = 1:numel(flowerImageSet)
     %testing images 
    numImages = numel(arrTestID); %     
    features  = zeros(numImages, featureSize);    
    for i = 1:numImages        
       img = rgb2gray(read(flowerImageSet(flower), arrTestID(i)));
        %img = read(flowerImageSet(flower), arrTrainID(i));
        %PLACEHOLDER#START 
        %img = read(flowerImageSet(flower), arrTrainID(i));
        %PLACEHOLDER#START
        features(i, :) = rand(1,featureSize);
      % features(i, :)=gradient_hist(img);
       %features(i, :)=color_hist(img);
       %features(i, :)=sift_hist(img);
        %
        %PLACEHOLDER#END      
    end
    
    % Use the imageSet Description as the training labels.  
    labels = repmat(flowerImageSet(flower).Description, numImages, 1);        
    testFeatures = [testFeatures; features];  
    testLabels   = [testLabels;   labels  ];  
end

% Step 4.2: Make class predictions using the test features.
predictedLabels = predict(classifier, testFeatures);

% Step 4.3: Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);
% The table shows the confusion matrix. The columns of
% the matrix represent the predicted labels, while the rows represent the
% known labels. 
%Training with a more representative data set, which contain thousands of images, is likely to
% produce a better classifier compared with the one created using this
% subset.

% Step 4.4: calculate accuracy
fprintf('accuracy=%f',sum(diag(confMat))/sum(confMat(:)));
%%


 



%% Summary
% This example illustrated the basic procedure for creating a multiclass
% object classifier using the feautre descriptors and the |fitcecoc| function from the
% Statistics and Machine Learning Toolbox(TM). Other feature descriptors and machine learning algorithms can be used in
% the same way. For instance, you can explore using different feature types
% for training the classifier; or you can see the effect of using other
% machine learning algorithms such as k-nearest neighbors. 