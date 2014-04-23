function haarFeature_top = plot_top_features( top, haarFeatureMasks,Alpha)

n = length(Alpha);
index = 1:n;
Alpha_index = [index;Alpha]';
Alpha_index = sortrows(Alpha_index,2); %Sort Alpha_index by the ascending weights.
Alpha_index = flipdim(Alpha_index,1);%Sort Alpha_index by the descending weights.
haarFeature_top = Alpha_index(1:top,1)';%access the top(5,or whatever defined by users) indice of the haarFeatureMasks

figure
colormap gray
for k = 1:25
subplot(5,5,k),imagesc(haarFeatureMasks(:,:,k),[-1 2]) %PLOT THE MOST IMPORTANT haarFeatureMasks
axis image,axis off
end

figure
colormap gray
for k = 1:top
subplot(1,top,k),imagesc(haarFeatureMasks(:,:,haarFeature_top(k)),[-1 2]) %PLOT THE MOST IMPORTANT haarFeatureMasks
axis image,axis off
end

end

