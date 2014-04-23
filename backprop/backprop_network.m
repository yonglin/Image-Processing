% Code skeleton for the Backprop Lab
%   Please see the solution to the class 3 backprop exercise for
%   the description of the network variables.
function [train_out, test_out, eval_out] = backprop_network(X, D, X_test, D_test, X_eval)


%Calculates the output of the network given the data and the weight
%matrices. Please see the solution for exercise 5.1 (class 5) for
%the description of the variables.
function [U] = evalNet(X,V,W)
   S = W*X;
   Y = tanh(S); % compute the hidden layer
   Y(1,:) = ones(1,size(X,2));%It is very tricky to consider Y as another "input", so we need turn Y's first row into 1's.
   U = tanh(V*Y); % the original codes is U = V*Y, but I think it is wrong, since you need to apply activation function at last.
end

%This function normalizes the data dimensions. If the data have the mean m and
% the standard deviation s, the output will have zero mean
% and unit variance over the samples.
function [X] = normData(X,m,s)
   for i = 1:length(X(:,1)); %Implement!
	X(i,:) = (X(i,:)-m(i))/s(i);  %Implement!
end


%% Start of code!
% Design parameters (feel free to change them!)
Nep      = 500;   %Number of epoches (training iterations)
dim_hidd = 2;     %Number of hidden neurons.
eta      = 0.05;  %Learning Rate

% Constants
N        = size(X,2);
N_test   = size(X_test,2);
dim_in   = size(X,1);
dim_out  = size(D,1);

% Normalize the data
Xmean = mean(X,2);
Xstd  = std(X,[],2);
if ~isempty(X_eval)
    X      = normData(X,Xmean,Xstd);
    X_test = normData(X_test,Xmean,Xstd);
    X_eval = normData(X_eval,Xmean,Xstd);
end

% Add the bias 'dimension'
X      = [ones(1,N) ; X];
X_test = [ones(1,N_test) ; X_test];
if ~isempty(X_eval)
    X_eval = [ones(1,size(X_eval,2)) ; X_eval];
end
% The weight matrices with dimensions dim_to x dim_from
V = 0.1*randn(dim_out,dim_hidd + 1);%for the output layer
W = 0.1*randn(dim_hidd + 1,dim_in + 1);%for the hidden layer. It is just oposite to the textbook. according to the line 13, this trick can help us deal with adding bias term to the hidden layer.

% Initialize the error vectors
E      = zeros(1,Nep);
E_test = zeros(1,Nep);

%Main training loop
for iter=1:Nep
   U = evalNet(X,V,W); %Evaluate the current network on the training data
   E(iter) = 1.0/(N*dim_out)*sum(sum((U-D).^2)); %Calculate the training error
   train_out = U;
   
   %Implement this! (Remove the stand in code...)
   %-----------------------------------------------
   %Remember the exercises from class!
   A = tanh(W*X):	
   A(1,:) = ones(1,size(X,2));
 
   Delta_0 = (U-D).*U.*(1-U);
   Delta_h = A.*(1-A).*((V')*Delta_0)% 3*N matrix
   grad_v = Delta_0*(A'); %Calculate the gradient for the output layer
   grad_w = Delta_h*(X'); %..and for the hidden layer.(3*N)*(N*3)=3*3
   W = W-grad_w; %Take the learning step.
   V = V-grad_v; %Take the learning step.
   
   
   %Test data
   U = evalNet(X_test,V,W); %Evaluate the current network on the test data
   E_test(iter) = 1.0/(N_test*dim_out)*sum(sum((U-D_test).^2)); %Calculate the test error
   test_out = U;
end

figure(10);hold off; clf;hold on;
plot(E,'b');
plot(E_test,'r');
E(end)
E_test(end)
legend('Training data','Test data');
title('Training plot (error versus iterations)');
hold off;

if ~isempty(X_eval)
    %Test on region and plot
    U = evalNet(X_eval,V,W);
    eval_out = U;

    [dummy,I] = max(U); %Make the classification (highest output value)
    figure(2);clf
    plot_fields(X_eval,I); hold on;
    figure(3);clf
    plot_fields(X_eval,I); hold on;

    figure(2);
    title('Training data result (green ok, yellow error)');
    [dummy,I]  = max(D);
    [dummy,I2] = max(train_out);
    plot_data(X,I,I2); hold off;
    fprintf('Number of errors (training): %d out of %d (%g %%)\n',sum(I~=I2),size(X,2),100*sum(I~=I2)/size(X,2));

    figure(3);
    title('Test data result (green ok, yellow error)');
    [dummy,I]  = max(D_test);
    [dummy,I2] = max(test_out);
    plot_data(X_test,I,I2); hold off;
    fprintf('Number of errors (test)    : %d out of %d (%g %%)\n',sum(I~=I2),size(X_test,2),100*sum(I~=I2)/size(X_test,2));
else
    samleNum = 1:N_test;
    [tmp ord] = sort(rand(1,N_test));
    [dummy,I] = max(test_out);
    [dummy,I2]  = max(D_test);
    I = I-1;
    I2 = I2-1;
    figure(2)
    clf
    for n = 1:16
        idx = ord(n);
        im = zeros(8,8);
        im(:) = X_test(2:end,idx);
        subplot(4,4,n)
        imagesc(im')
        colormap(gray)
        title(['D=' num2str(I2(idx)) ', Net=' num2str(I(idx))])
    end
    [dummy,I] = max(train_out);
    [dummy,I2]  = max(D);
    
    fprintf('Number of errors (training): %d out of %d (%g %%)\n',sum(I~=I2),size(X,2),100*sum(I~=I2)/size(X,2));
    [dummy,I] = max(test_out);
    [dummy,I2]  = max(D_test);
    
    fprintf('Number of errors (test)    : %d out of %d (%g %%)\n',sum(I~=I2),size(X_test,2),100*sum(I~=I2)/size(X_test,2));

end

end

%Function for plotting the boundaries
% You don't have to understand this code !
function plot_fields(X,I)
  nx=sum(X(2,:) == X(2,1));
  ny=sum(X(3,:) == X(3,1));
  
  if(nx*ny ~= size(X,2))
     %Scattered data
     xi=linspace(min(X(2,:)),max(X(2,:)),300);
     yi=linspace(min(X(3,:)),max(X(3,:)),300);
     [XI,YI] = meshgrid(xi,yi);
     ZI = griddata(X(2,:),X(3,:),I,XI,YI);
     imagesc(xi,yi,ZI);
  else
     %Rectangular sample pattern
     imagesc(X(2,:),X(3,:),reshape(I,nx,ny));
  end
end

%Function for plotting the data
% You don't have to understand this code !
function plot_data(X,I,I2)
   c='xo+*sd';
   hold on
   for k=1:6
      ind     = (I == k) & (I == I2);
      ind_err = (I == k) & (I ~= I2);
      plot(X(2,ind),X(3,ind),strcat('g',c(k)));
      plot(X(2,ind_err),X(3,ind_err),strcat('y',c(k)));
   end
   hold off
end


