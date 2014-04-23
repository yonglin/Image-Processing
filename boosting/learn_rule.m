function indicator = learn_rule(x, r)
%simple learn rule for only one dimension and one threshold
if x < r
    indicator = 1;
else
    indicator = -1;
end

end

