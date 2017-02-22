% Algorithm for estimating the 1D mean of a general distribution with
% bounded fourth moments in a direction v
%
% Input: Noisy samples from a general distribution with bounded fourth
% moments, column vector v, noise fraction eta
% Output: estimate of the mean and variance along the direction v

function mu = estGeneral1D(X, v, eta)
    
    v = v/norm(v); %normalize
    m = size(X,1);
    Z = X*v;
    Z = sort(Z);
    
    intervalWidth = floor(m*(1-eta)^2);
    lengths = zeros(m - intervalWidth + 1, 1);
    
    for i = 1:m - intervalWidth + 1
        lengths(i) = Z(i + intervalWidth - 1) - Z(i);
    end
    
    [~,ind] = min(lengths);
    ind = ind(1);
    mu = mean(Z(ind:ind + intervalWidth - 1));

end