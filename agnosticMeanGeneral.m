% Agnostic algorithm for computing mean of a general distribution with 
% bounded fouth moments
%
% Input: X = noisy data from a general distribution with bounded fourth
% moments, noise fraction eta
% Output: est = estimate for the mean

function est = agnosticMeanGeneral(X, eta)

n = size(X,2);

if n <= 1
    est = estGeneral1D(X, 1, eta);
    return;
end

w = outRemBall(X, eta);
newX = X(w>0,:);
%newX = bsxfun(@times, X, sqrt(w));

S = cov(newX);

[V,D] = eig(S);

if ~issorted(diag(D)) % check if eigvecs are in ascending order
    [~,inds] = sort(diag(D));
    V = V(:, inds);
end

PW = V(:, 1:floor(n/2))*V(:, 1:floor(n/2))';
%weightedProjX = bsxfun(@times, X*PW, w);
weightedProjX = newX*PW;
est1 = mean(weightedProjX); %weighted mean

QV = V(:, floor(n/2)+1:end);
est2 = agnosticMeanGeneral(X*QV, eta);
est2 = est2*QV';
est = est1 + est2;

end

