  
% Step-1: Load training and test data using imageSet.
imageDir   = fullfile('./data');

% imageSet recursively scans the directory tree containing the images.
directImageSet = imageSet(imageDir,   'recursive'); 

% The directImageSet is an array of 8 imageSet objects: one for each direct.
%directImageSet(1): for the type 1
%directImageSet(2): for the type 2
%directImageSet(3): for the type 3

% Show direct examples
% figure;
% subplot(1,8,1);
% imshow(directImageSet(1).ImageLocation{1});
% subplot(1,8,2);
% imshow(directImageSet(2).ImageLocation{2});
% subplot(1,8,3);
% imshow(directImageSet(3).ImageLocation{3});
% subplot(1,8,4);
% imshow(directImageSet(4).ImageLocation{4});
% subplot(1,8,5);
% imshow(directImageSet(5).ImageLocation{5});
% subplot(1,8,6);
% imshow(directImageSet(6).ImageLocation{6});
% subplot(1,8,7);
% imshow(directImageSet(7).ImageLocation{7});
% subplot(1,8,8);
% imshow(directImageSet(8).ImageLocation{8});

%% step-2: Partition the data set into a training set and a test set.

 

tmparr=randperm(150);
arrTrainID=tmparr(1:100); %training ID; 
arrTestID=tmparr(101:end);% testing ID;  

 
%% Step-3: Train the classifier using features extracted from the training set.
trainingFeatures = [];
trainingLabels   = [];

cellSizeArray = [4,8,16,32,64,128];
accuracyArray = zeros(1,length(cellSizeArray));

for ii = 1:length(cellSizeArray)
   cellsize = cellSizeArray(ii);
   image = ones(4,4);
   x = HOG(image, cellsize);
   featureSize = size(x,2);
   display(featureSize);

    %%
    trainingFeatures = [];
    trainingLabels = [];
    for direct = 1:numel(directImageSet)

        numImages = numel(arrTrainID);           
        features  = zeros(numImages, featureSize);

        for i = 1:numImages

            img = rgb2gray(read(directImageSet(direct), arrTrainID(i)));

            %PLACEHOLDER#START        
             features(i, :) =HOG(img,cellsize);
            %PLACEHOLDER#END
        end

        % Use the imageSet Description as the training labels.  
        labels = repmat(directImageSet(direct).Description, numImages, 1);
        
        trainingFeatures = [trainingFeatures; features];  
        trainingLabels   = [trainingLabels;   labels  ];  

    end

    classifier = fitcecoc(trainingFeatures, trainingLabels);

    %% Step 4: Evaluate the direct Classifier
    testFeatures=[];
    testLabels=[];
    % Step 4.1: Loop over the testing images and extract features from each image. 
    for direct = 1:numel(directImageSet)
         %testing images 
        numImages = numel(arrTestID); %     
        features  = zeros(numImages, featureSize);    
        for i = 1:numImages        
            img = rgb2gray(read(directImageSet(direct), arrTestID(i)));  
            %PLACEHOLDER#START        
            features(i, :) = rand(1,featureSize);
            features(i, :) =HOG(img,cellsize);
            %PLACEHOLDER#END      
        end

        % Use the imageSet Description as the training labels.  
        labels = repmat(directImageSet(direct).Description, numImages, 1);        
        testFeatures = [testFeatures; features];  
        testLabels   = [testLabels;   labels  ];  
    end

    % Step 4.2: Make class predictions using the test features.
    predictedLabels = predict(classifier, testFeatures);

    % Step 4.3: Tabulate the results using a confusion matrix.
    confMat = confusionmat(testLabels, predictedLabels);


    % Step 4.4: calculate accuracy

    accuracy=sum(diag(confMat))/sum(confMat(:));
    fprintf('accuracy=%f',accuracy);
    accuracyArray(ii) = accuracy;

end
%%
figure;
plot(cellSizeArray, accuracyArray);




 


