% Computes the mean of a general Gaussian given noisy samples X
function est = agnosticMeanG(X)

%TODO: debug
m = size(X,1);
n = size(X,2);

if n<=1
    est = median(X);
    return;
end

w = outlierDamping(X);

muHat = w'*X/m;

S = zeros(n,n);
for i=1:m
    S = S + w(i)*(X(i,:) - muHat) * (X(i,:) - muHat)';
end
S = S/m; % weighted covariance matrix

[V,~] = eig(S);
PW = V(:, 1:floor(n/2))*V(:, 1:floor(n/2))';
est1 = mean(X*PW);

QV = V(:, floor(n/2)+1:end);
est2 = agnosticMeanG(X*QV);
est2 = est2*QV';
est = est1 + est2;

end