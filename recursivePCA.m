% Agnostic algorithm for computing mean of a Gaussian
% 
% Input: data X from a Gaussian, outlierRemoval procedure
% Output: estimate for the mean

function est = recursivePCA(X,sig,outlierRemoval)

m = length(X);
n = size(X,2);

if n<=2
    est = median(X);
    return;
end

% iter = ceil(m/2);
% R = zeros(iter,1);
% for i=1:iter
% i1 = ceil(rand()*m); j1 =  ceil(rand()*m);
% R(i) = norm(X(i1,:) - X(j1,:));
% end
% sig = median(R)/sqrt(n);


r = sig*sqrt(n);
[X] = outlierRemoval(X,r);

S = cov(X);
[V,~] = eig(S);
PW = V(:, 1:floor(n/2))*V(:, 1:floor(n/2))';
est1 = mean(X*PW);

QV = V(:, floor(n/2)+1:end);
est2 = recursivePCA(X*QV,sig);
est2 = est2*QV';
est = est1 + est2;

%est = mean(X);

end