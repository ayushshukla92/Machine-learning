function [J, grad] = costFunctionReg(theta, X, y, lamda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

Htheta=sigmoid(X*theta);
J=y'*(log(Htheta))+(1-y)'*log(1-Htheta);
J=-J/m+(lamda/(2*m))*sum(theta.*theta);
J=J-(lamda/(2*m))*theta(1)*theta(1);
grad(1)=(1/m)*(Htheta-y)'*X(:,1);

for j=2:size(theta)
   grad(j)= (1/m)*(Htheta-y)'*X(:,j)+(lamda/m)*(theta(j));
end



% =============================================================

end
