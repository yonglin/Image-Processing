function [Alpha,Learner] = ada_boost( X,Y)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
m = length(Y);
T = length(X(:,1));%the nbr of weak learners is the dimension of the feature space
D = ones(1,m)/m;% the initial weight vector
Learner = ones(T,3);
Epslon = ones(1,T);%store the error of each weak learner
Alpha = ones(1,T);% store the weight of each choosen learner
for t = 1:T
    learner = get_best_learner(Y,X(t,:),D);
    Learner(t,:) = learner;
    Epslon(t) = learner(3);
    Alpha(t) = 0.5*(log((1-Epslon(t))/Epslon(t)));
    for i = 1:m
        if H(learner,X(t,i))~=Y(i)
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

