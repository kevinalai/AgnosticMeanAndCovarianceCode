% Removes points outside of a ball containing (1-eta)^2 fraction of the
% points. The ball is centered at the coordinate-wise median.
% The weight vector returned has 0 weight for points from X that are
% outside this ball.
%
% Input: X = sample from a distribution with bounded fourth moments,
% noise fraction eta
% 
% Output: weight (column) vector w that is 0 for "removed" points

function [w] = outRemBall(X, eta)

m = size(X, 1);
med = median(X);

w = ones(m, 1);

Z = X - repmat(med, m, 1); 

T = sum(Z.^2,2);
thresh = prctile(T, 100*(1-eta)^2);

w(T > thresh) = 0;
%fprintf('dim = %d and numOverThresh = %d, median norm = %f\n',n,sum(T> C*thresh), norm(med));

end