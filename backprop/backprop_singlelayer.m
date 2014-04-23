%% Code skeleton for the Backprop Lab
%   Please see the solution to the class 3 backprop exercise for
%   the description of the network variables.
function [train_out, test_out, eval_out] = backprop_singlelayer(X, D, X_test, D_test, X_eval)%how matlab define a fuction


%Calculates the output of the network given the data and the weight
%matrices. Please see the solution for exercise 5.1 (class 5) for
%the description of the variables.
function [U] = evalNet(X,W)% define the fuction which computes the nexwork
   U = W*X; %compute the forward network
end

%This function normalizes the data dimensions. If the data have the mean m and
% the standard deviation s, the output will have zero mean
% and unit variance over the samples.

function [X] = normData(X,m,s) % normalize the original data
    X_trans = [];
    for x = X';
        X_trans = [X_trans (x-m)/s];
    end
    X = X_trans'
end       
        

%Belowing codes are much fewer, but the above codes are much more structual
% function [X] = normData(X) 
% X_trans = X';
% X_norm =[];
% for x = X_trans;
%     x_mean = mean(x);
%     x_norm = (x - x_mean)/std(x);
%     X_norm = [X_norm x_norm];
% end
% X= X_norm';
% end

%% Start of code!
% Design parameters (feel free to change them!)
Nep      = 500;   %Number of epoches (training iterations)
eta      = 0.05;  %Learning Rate

% Constants
N        = size(X,2); % the number of columns of X, which is the number of observations in training set
N_test   = size(X_test,2); % the numner of columns of X_test
dim_in   = size(X,1); % the number of rows of X
dim_out  = size(D,1); % the number of rows of D

% Normalize the data
Xmean = mean(X,2); % recall the mean function for the rows of X
Xstd  = std(X,[],2); % recall the standard deviation function of the rows of X. if middle parameter is the flag of which kind of std
                     % 0 means unbiased std 1 means biased. you can use command "doc std" to see the details
X      = normData(X,Xmean,Xstd); % recall the function normData
X_test = normData(X_test,Xmean,Xstd);
X_eval = normData(X_eval,Xmean,Xstd);

% Add the bias 'dimension' It is easily to forget this step.
X = [ones(1,N) ; X]; % Be careful about expanding a matrix. If you wanna add a row B before the first row, you need this form X=[b;X]
% if you just wanna add a column before the first column, you need to do
% this X =[b X] no semicolon!!!
X_test = [ones(1,N_test) ; X_test];
X_eval = [ones(1,size(X_eval,2)) ; X_eval];

% The weight matrices with dimensions dim_to x dim_from
W = 0.1*randn(dim_out,dim_in + 1); % the extra dimension is given to the bias 

% Initialize the error vectors
E      = zeros(1,Nep);
E_test = zeros(1,Nep);

%Main training loop
for iter=1:Nep
   U = evalNet(X,W); %Evaluate the current network on the training data "forward feed step"
   E(iter) = 1.0/(N*dim_out)*sum(sum((U-D).^2)); %Calculate the training error. 
                                                 %Notice that the inner "sum" caculates each column's sum of square
   train_out = U;
   
   %Implement this! (Remove the stand in code...)
   %-----------------------------------------------
   %Remember the exercises from class!
   grad_w = X*(U-D)'; %..and for the hidden layer.
   W = W - eta*grad_w; %Take the learning step.
   
   
   %Test data
   U = evalNet(X_test,W); %Evaluate the current network on the test data
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


%Test on region and plot
U = evalNet(X_eval,W);
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


