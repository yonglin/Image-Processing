function [Alpha,Learner] = ada_boost_T( X,Y,T)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
m = length(Y);
n = length(X(:,1));
n = randperm(n);%the nbr of weak learners is the dimension of the feature space
D = ones(1,m)/m;% the initial weight vector
X_Learner = X(n(1:T),:);
Learner = ones(T,3);
Epslon = ones(1,T);%store the error of each weak learner
Alpha = ones(1,T);% store the weight of each choosen learner
for t = 1:T
    learner = get_best_learner(Y,X_Learner(t,:),D);
    Learner(t,:) = learner;
    Epslon(t) = learner(3);
    Alpha(t) = 0.5*(log((1-Epslon(t))/Epslon(t)));
    for i = 1:m
        if H(learner,X_Learner(t,i))~=Y(i)
            D(i) = D(i)*exp(Alpha(t));
        else
            D(i) = D(i)*exp(-Alpha(t));
        end
    end
    sum_D = sum(D);
    D = D/sum_D;
end
%symbol = test_single(Learner,x_test,Alpha);

end

