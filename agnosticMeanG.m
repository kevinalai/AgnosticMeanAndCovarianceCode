% Agnostic algorithm for computing mean of a general Gaussian
%
% Input: X = noisy data from a general Gaussian
% Output: est = estimate for the mean

function est = agnosticMeanG(X, eta)

m = size(X,1);
n = size(X,2);

if n<=2
    est = median(X);
    return;
end

w = outlierRemoval(X, eta);

muHat = w'*X/m;
norm(muHat);

C = X - repmat(muHat, m, 1);
C = bsxfun(@times, C, sqrt(w));

%for i=1:m
%    S = S + (X(i,:) - muHat)' * (X(i,:) - muHat);
%end
S = C'*C; %does the outer product from above

S = S/m; % weighted covariance matrix

[V,~] = eig(S);
PW = V(:, 1:floor(n/2))*V(:, 1:floor(n/2))';
weightedProjX = bsxfun(@times, X*PW, w);
est1 = mean(weightedProjX);

QV = V(:, floor(n/2)+1:end);
est2 = agnosticMeanG(X*QV, eta);
est2 = est2*QV';
%fprintf('dim = %d, mean norm here = %f\n', n, norm(est2));
est = est1 + est2;

end

function [w] = outlierRemoval(X, eta) 

    m = size(X,1);
    n = size(X,2);

    w = outlierDamping(X);
    %w = ones(m, 1);
    %w = outRemBall(X, eta);

    %w = outRemSpherical(X, sqrt(n));
    %size(w)

    %r = sqrt(n);
    %w = ones(m, 1);
    %Z = X - repmat(med,m,1); 
    %T = sum(Z.^2,2);
    %w(T > 2*r*r) = 0;
    %size(w)


end
