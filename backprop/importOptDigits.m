function [ X, Xt, D, Dt ] = importOptDigits( input_args )
%IMPORTOPTDIGITS Summary of this function goes here
%   Detailed explanation goes here
%%
X = importfile('optdigits.tra');
Xt = importfile('optdigits.tes');
Dtmp = X(:,65);
Dttmp = Xt(:,65);

X(:,65) = [];
Xt(:,65) = [];

D = -0.99*ones(10,size(X,1));
Dt = -0.99*ones(10,size(Xt,1));

for n = 1:10
    D(n,Dtmp==n-1) = 0.99;
    Dt(n,Dttmp==n-1) = 0.99;
end

X = X.';
Xt = Xt.';



end

