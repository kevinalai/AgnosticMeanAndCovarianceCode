% Output: Several vectors of values corresponding to the performance of
% the algorithm, the coordinate-wise median, and the mean of the true
% samples
% vecs contains the vectors for the algorithm's estimate and the mean of
% the true samples for dimension equal to the largest value of drange
% This code also plots the performance of the different estimators over a
% range of values of the dimension.

function [algError, medError, trueSampleError] = covTesterGeneral()

drange = [40:10:60];
%drange = [500];

algError = zeros(size(drange));
medError = zeros(size(drange));
trueSampleError = zeros(size(drange));
vecs = zeros(3, drange(end));

eta = .1;

for i = 1:size(drange,2)
    d = drange(i);
    m = d^2;
    %X = noisyG(zeros(d,1), eye(d), 2*ones(d,1), eta, m);
    I = eye(d);
    %trueMu = I(1,:);
    
    trueMu = zeros(1,d); % Set the mean of the true distribution
    trueCov = 3*eye(d); % Set the covariance of the true distribution
    
    mD = floor((1-eta)*m);
    mN = m - mD;
    
    trueDistType = 1; % Set the type of the true distribution
    % 1: Gaussian
    % 2: GMM (to set mixture parameters, see code below)
    % 3: Uniform in standard simplex
    % trueMu and trueCov variables are only used for Gaussian
    
    Y = genTruePoints(d, trueMu, trueCov, mD, trueDistType);
    Z = cauchyrnd(2, 1, mN, d); %noise distribution
    %Z = 10000*randn(mN, d);
    X = [Y;Z];
    %X = Y;
    [muHat, SigmaHat, ~] = agnosticCovarianceGeneral(X, eta);
    fprintf('%d : %f\n', d, norm(muHat));
    
    C = num2cell(X, 2);
    XX = cell2mat(cellfun(@outerProdToVec, C, 'UniformOutput', 0));
    % XX is a matrix where each row is the d^2 length vector corresponding
    % to the outer product of a sample
    
    CC = num2cell(Y, 2);
    YY = cell2mat(cellfun(@outerProdToVec, CC, 'UniformOutput', 0));
    % YY is a matrix where each row is the d^2 length vector corresponding
    % to the outer product of a true sample
    
    medvec = median(XX);
    med = reshape(medvec, [d d]);
    trueSampleMeanVec = mean(YY);
    trueSampleMean = reshape(trueSampleMeanVec, [d d]);
    
    
    algError(i) = norm(SigmaHat - trueCov, 'fro');
    medError(i) = norm(med - trueCov, 'fro');
    trueSampleError(i) = norm(trueSampleMean - trueCov, 'fro');
    
    clf
    plot(drange(1:i), algError(1:i),'--o', drange(1:i), medError(1:i),'-o', drange(1:i), trueSampleError(1:i),'-*');
    legend('Algorithm norm', 'Coord-median', 'True sample mean norm', 'Location', 'NorthEastOutside');
    axis([0 drange(end) 0 14])
    drawnow
end

%plot(drange, algError, drange, medError, drange, trueSampleError);%, drange, vals3);
%legend('Algorithm norm', 'Coord-median', 'True sample mean norm', 'Location', 'NorthEastOutside');


end

% trueMu parameter only transfers to mvnrnd
% 1: Gaussian
% 2: GMM (to set mixture parameters, see code below)
% 3: Uniform in standard simplex
function [Y] = genTruePoints(d, trueMu, trueCov, numPts, type)

    if type == 1
        %Gaussian
        Y = mvnrnd(trueMu, trueCov, numPts);
    elseif type == 2
        %GMM
        Y = useGMM(d, numPts);
    elseif type == 3
        %Uniform in simplex
        Y = useSimplex(d, numPts);
    else
        fprintf('Invalid type provided. Using Gaussian.\n')
        Y = mvnrnd(trueMu, trueCov, numPts);
    end
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


%transform row vector v to outer product and then reshape into vector
function out = outerProdToVec(v)
    len = size(v, 2);
    V = v'*v;
    out = reshape(V,[1, len*len]);
end



