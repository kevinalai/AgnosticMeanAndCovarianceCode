% input mean, variance, noise fraction eta, number of samples m,
% and a noise point z. Outputs a matrix of samples, where the first 1-eta
% fraction are from N(mu, var), and the last eta fraction are repeats of
% the vector z
% output has m rows (one per sample point) and n columns (one per
% dimension)
function [X] = noisyG(mu, var, z, eta, m)

dim = size(z,2);
mN = ceil(eta*m);
mG = m - mN;

Y = mvnrnd(mu, var, mG);
Z = repmat(z,mN,1);

X = [Y; Z];

end