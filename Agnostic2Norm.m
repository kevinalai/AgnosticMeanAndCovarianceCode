function Sigma2 = Agnostic2Norm(X,alpha)

m = length(X);
n = size(X,2);
muHat = median(X);
r = (n)^(1/2)*log(n)^(1/alpha);

X = outRemSpherical(X,r);  %TODO: figure this out


end