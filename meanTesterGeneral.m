% Output: Several vectors of values corresponding to the performance of
% the algorithm, the coordinate-wise median, and the mean of the true
% samples
% vecs contains the vectors for the algorithm's estimate and the mean of
% the true samples for dimension equal to the largest value of drange
% This code also plots the performance of the different estimators over a
% range of values of the dimension.

function [algError, medError, trueSampleError, vecs] = meanTesterGeneral()

drange = [50:50:200 300:100:600];
%drange = [500];

algError = zeros(size(drange));
medError = zeros(size(drange));
sampleError = zeros(size(drange));
trueSampleError = zeros(size(drange));
vecs = zeros(3, drange(end));

eta = .1;

for i = 1:size(drange,2)
    d = drange(i);
    m = 10*d;
    %X = noisyG(zeros(d,1), eye(d), 2*ones(d,1), eta, m);
    I = eye(d);
    trueMu = I(1,:);
    trueMu = zeros(1,d);
    Y = genTruePoints(d, trueMu, (1-eta)*m);
    Z = cauchyrnd(2, 1, eta*m, d);
    X = [Y;Z];
    est = agnosticMeanGeneral(X, eta);
    
    algError(i) = norm(est-trueMu);
    medError(i) = norm(median(X)-trueMu);
    sampleError(i) = norm(mean(X)-trueMu);
    trueSampleError(i) = norm(mean(Y)-trueMu);
    if d == drange(end)
        vecs(1,:) = est;
        vecs(2,:) = mean(Y);
        vecs(3,:) = median(Y);
    end
end

plot(drange, algError, drange, medError, drange, trueSampleError);%, drange, vals3);
legend('Algorithm norm', 'Coord-median', 'True sample mean norm', 'Location', 'NorthEastOutside');


end

% trueMu parameter only transfers to mvnrnd
function [Y] = genTruePoints(d, trueMu, numPts)

    %Gaussian
    Y = mvnrnd(trueMu, 3*eye(d), numPts);
    
    %GMM
    %Y = useGMM(d, numPts);
    
    %Uniform in simplex
    %Y = useSimplex(d, numPts);
    
end

function Y = useSimplex(d, numPts)
    Z = gamrnd(1, 1, numPts, d+1); % generate points from d+1 dimensional Dirichlet
    a = sum(Z, 2);
    Z = bsxfun(@rdivide, Z, a); % normalize
    Y = Z(:, 1:d); % Only use the first d coordinates to get a point inside the simplex

end

function [Y] = useGMM(d, numPts)
    A = eye(d);
    w1 = .2; mu1 = zeros(1, d); Sigma1 = eye(d);
    mu2 = A(1, :); Sigma2 = 2*eye(d);
    Y = generateGMMsamples(numPts, w1, mu1, Sigma1, mu2, Sigma2);

end



