function hypothesis = H(learner,x )
%how can a learner learn for a coordinate. learner is like this: leaner =
%(r,-1,e) r represents the threshold, -1 means we need to convert the sign
%of the reslut as -1, e stands for the error of such a leaner for the
%training example

if learner(2) == 1
    hypothesis = learn_rule(x,learner(1));
else
    hypothesis = -learn_rule(x,learner(1));
end

end

