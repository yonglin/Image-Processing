function [ test_error,train_error ] = error_test_train(xTest,yTest,xTrain,yTrain,Learner,Alpha)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
test_error = test_overall_pure( xTest,yTest,Learner,Alpha);
train_error = test_overall_pure( xTrain,yTrain,Learner,Alpha);
end

