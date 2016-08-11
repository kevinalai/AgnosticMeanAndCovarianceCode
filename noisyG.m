% Method for generating points from a spherical Gaussian with noise placed
% at a single point
% 
% Input: mean, covariance matrix, noise fraction eta, number of samples m,
% and a noise point z. Mean and z are column vectors in n dimensions
%
% Output: a matrix X of samples, where in expectation, first 1-eta
% fraction are from N(mu, var), and the last eta fraction are repeats of
% the vector z
% The output has m rows (one per sample point) and n columns (one per
% dimension)

function [X] = noisyG(mu, Sigma, z, eta, m)

mN = binornd(m, eta); %ceil(eta*m);
mG = m - mN;

Y = mvnrnd(mu', Sigma, mG);
Z = repmat(z', mN, 1);

X = [Y; Z];

end