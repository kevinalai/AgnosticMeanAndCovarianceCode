% Algorithm for estimating 1D mean and variance of a Gaussian in a
% direction v

% Input: Noisy samples from a general Gaussian
% Output: estimate of the mean and variance along the direction v
function [mu, sigma2] = estG1D(X, v)

    m = size(X,1);
    Z = X*v;
    mu = median(Z);
    Z = Z - repmat(mu, m, 1);

    sigma2 = Z'*Z/m;
end