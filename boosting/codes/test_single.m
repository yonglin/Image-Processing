function indicator = test_single( Learner,Alpha ,x)
%can test single new observation by using the training result. Learner
%represents the set of learners we have picked, x means the new training
%data, and Alpha stands for the weight of each learner

T = length(Alpha);
L = ones(T,1);
for t = 1: T
    if Learner(t,2) == 1
        L(t) = learn_rule(x(t),Learner(t,1));
    else
        L(t) = -learn_rule(x(t),Learner(t,1));
    end
end
indicator = sign(Alpha*L);

end

