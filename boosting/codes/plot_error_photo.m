function error_photo_index = plot_error_photo( Y_indicate,testImages)

n = length(Y_indicate(1,:));
K = sum(abs(Y_indicate(1,:)))/2;
frame = floor(sqrt(K))+1;
Y_indicate_1=Y_indicate(1,:);
Y_indicate_2=Y_indicate(2,:);
error_photo_index = [];
for i = 1:n
    if Y_indicate_1(i)~=0
        error_photo_index = [error_photo_index,Y_indicate_2(i)];
    end
end
K_1 = length(error_photo_index);
figure
colormap gray
for k = 1:K_1
subplot(frame,frame,k),imagesc(testImages(:,:,error_photo_index(k))),axis image,axis off%PLOT THE misclassifying photos

end

end
