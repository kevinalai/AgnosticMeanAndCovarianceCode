% Outlier damping for Gaussian Agnostic PCA
%
% Input: X = noisy sample from a general Gaussian
% Output: w = column vector of weights for each sample

function w = outlierDamping(X)

C = 1;

[s2, Z] = traceEst(X);

s2 = C*s2;

T = sum(Z,2); % matrix of squared distances from median
w = exp(-T/s2); % matrix exponential of each entry

end

% T is trace estimate, Z is squared distances from each coordinate median
function [T,Z] = traceEst(X)

m = size(X,1);
n = size(X,2);

meds = zeros(1, n);

I = eye(n);

T = 0;
for i = 1:n
    [meds(i), sigma2] = estG1D(X, I(:, i));
    T = T + sigma2;
end

X = X - repmat(meds, m, 1);
Z = X.^2;

end

