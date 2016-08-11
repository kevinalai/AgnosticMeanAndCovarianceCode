% Algorithm for estimating 1D mean and variance of a Gaussian in a
% direction v

% Input: Noisy samples from a general Gaussian
% Output: estimate of the mean and variance along the direction v
function [mu, sigma2] = estG1D(X, v)
    
    v = v/norm(v); %normalize
    m = size(X,1);
    Z = X*v;
    mu = median(Z);
    Z = Z - repmat(mu, m, 1);
    
    % subtract 60th quantile location from 40th quantile
    topQuant = .6;
    botQuant = .4;
    diff = quantile(Z,topQuant) - quantile(Z,botQuant);
    
    sigma2 = (diff/(norminv(topQuant, 0, 1) - norminv(botQuant, 0, 1)))^2;
end