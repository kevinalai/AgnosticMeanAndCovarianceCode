% Generates m samples from a general GMM with the given parameters
function x = generateGMMsamples(m, w1, mu1, Sigma1, mu2, Sigma2)

d = size(mu1, 2);
x = zeros(m, d);
numOnes = binornd(m, w1);

x(1:numOnes,:) = mvnrnd(mu1, Sigma1, numOnes);
x(numOnes+1:end,:) = mvnrnd(mu2, Sigma2, m - numOnes);

end

