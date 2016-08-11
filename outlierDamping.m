% Outlier damping for Gaussian Agnostic PCA
% Input: sample X
% Output: Column vector w of weights  for each sample
function w = outlierDamping(X)

C = 1;

[s2,Z] = traceEst(X);
s2 = C*s2;

T = sum(Z,2); % matrix of squared distances from median
w = exp(1).^(-T/s2);

end

% T is trace estimate, Z is squared distances from each coordinate median
function [T,Z] = traceEst(X)

m = size(X,1);
n = size(X,2);
%sigma2 = zeros(n,1);
%I = eye(n);

meds = median(X);
X = X - repmat(meds, m, 1);
Z = X.^2;
sigma2 = sum(Z)/m;

T = sum(sigma2);

end

