function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%

M=(X*Theta'-Y);
M=M.*M;
M=M/2;
M=R.*M;
J=sum(sum(M));
J=J+(lambda/2)*((sum(sum(Theta.^2)))+(sum(sum(X.^2))));

%X_grad=((X*Theta'-Y).*R)*Theta;

% for i=1:num_movies
%     for k=1:num_features
%         temp=0;
%         for j=1:num_users
%            if R(i,j)==1
%                temp=temp+(Theta(j,:)*X(i,:)')*Theta(j,k);
%            end
%         X_grad(i,k)=temp;
%     end
% end
% 
% 
% for j=1:num_users
%     for k=1:num_features
%         temp=0;
%        for i=1:num_movies
%           if R(i,j)==1
%               temp=temp+(Theta(j,:)*X(i,:)')*X(i,k);
%           end
%        end
%        Theta_grad(j,k)=temp;    
%     end
% end
for i=1:num_movies
  idx = find(R(i, :)==1);    % users that have rated movie i.
  Theta_tmp = Theta(idx, :);     % user features of movie i.
  Y_tmp = Y(i, idx);         % user's ratings of movie i.
  X_grad(i, :) = (X(i, :)*Theta_tmp' - Y_tmp)*Theta_tmp;
  X_grad(i, :) = X_grad(i, :)+lambda*X(i, :); % regularized term of x.
end

% calculating gradient of theta.
for j=1:num_users
  idx = find(R(:, j)==1)'; % movies that have rated by user j.
  X_tmp = X(idx, :);       % features of movies rated by user j.
  Y_tmp = Y(idx, j);       % user ratings by user j.
  Theta_grad(j, :) = (X_tmp*Theta(j, :)'-Y_tmp)'*X_tmp;
  Theta_grad(j, :) = Theta_grad(j, :)+lambda*Theta(j, :); % regularized term of theta.
end



% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
