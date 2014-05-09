function indicator = single_loss(a, b)
%compute the 0-1 loss for two single number

if a == b
    indicator = 0;
else
    indicator = 1;
end
end

