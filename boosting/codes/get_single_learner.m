function learner = get_single_learner(Y,x,W,r )
%compute the error of a particular threshold and weight vector W
% 
h = learn_single(x,r); %get the learning result of for such a coordinate and threshold
epslon = loss_function(Y,h,W);
if epslon > 0.5
    epslon = 1-epslon;
    learner = [r, -1,epslon]; % we just mark the learner as -1 who has the original error > 0.5, 
                              % which indicates us that we need to convert
                              % sign of h to -1
                              % when if we need to use such a learner
                              % later
    
else
    learner = [r, 1, epslon]; %we just mark the learner as 1 who has the original error < 0.5
end

end

