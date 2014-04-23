function overall_loss = loss_function( Y, h, W )
%compute the weighted loss of two vectors Y anf h
%W is the weight vector
overall_loss = 0;
for i = 1:length(Y)
    overall_loss = overall_loss + W(i)*single_loss(Y(i),h(i));
end

end

