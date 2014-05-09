function [Y_indicate,overall_error] = test_overall( X,Y,Learner,Alpha)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

m = length(Y);
Y_hat = ones(1,m);
for i = 1:m
    Y_hat(i) = test_single(Learner,Alpha,X(:,i));
end
Y_indicate = Y-Y_hat;
Y_index = 1:m;
Y_indicate = [Y_indicate;Y_index];
overall_error = sum(abs(Y_hat-Y))/(2*m);% this trick is to estimate the error of the trained learner
end

