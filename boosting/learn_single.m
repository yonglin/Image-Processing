function result = learn_single(x,r )
%Compute the learning result of one demision of all the observations, r is the
%threshold
%x is the vector who contains the value of one coordinate of the whole data
%set

result = ones(1,length(x));
for i = 1:length(x)
    result(i) = learn_rule(x(i),r);
end
end

