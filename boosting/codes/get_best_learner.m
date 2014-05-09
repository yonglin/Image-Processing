function best_learner = get_best_learner(Y,x,W)
%we use this to get the best learner(best threhold for the specific
%coordinate of our feature space
%
m = length(x);
best_learner = ones(m,3);%used for storing the the best learner of this coordinate, each row stands for one learner.
% best_learner = [];
% for r = R% just try every value of this coordinate from different training data
%     best_learner = [best_learner;get_single_learner(Y,x,W,r)];
% end
for i = 1:m
    best_learner(i,:) = get_single_learner(Y,x,W,x(i));
end
    best_learner = sortrows(best_learner,3);
    best_learner = best_learner(1,:);
end

