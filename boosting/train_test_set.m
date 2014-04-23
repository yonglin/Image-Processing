function [trainImages,testImages,haarFeatureMasks,xTrain,yTrain,xTest,yTest] = train_test_set( nbrHaarFeatures,nbrTrainExamples,nbrTestExamples )
% Generate Haar feature masks
load faces;
load nonfaces;
faces = double(faces);
nonfaces = double(nonfaces);
haarFeatureMasks = GenerateHaarFeatureMasks(nbrHaarFeatures);
% Create a training data set with a number of training data examples
% from each class. Non-faces = class label y=-1, faces = class label y=1
trainImages = cat(3,faces(:,:,1:nbrTrainExamples),nonfaces(:,:,1:nbrTrainExamples));
xTrain = ExtractHaarFeatures(trainImages,haarFeatureMasks);
yTrain = [ones(1,nbrTrainExamples), -ones(1,nbrTrainExamples)];

% Create a testing data set with a number of testing data examples

start_test = nbrTrainExamples+1;
end_test = nbrTrainExamples+nbrTestExamples;
testImages = cat(3,faces(:,:,start_test:end_test),nonfaces(:,:,start_test:end_test));
xTest = ExtractHaarFeatures(testImages,haarFeatureMasks);
yTest = [ones(1,nbrTestExamples), -ones(1,nbrTestExamples)];
end

