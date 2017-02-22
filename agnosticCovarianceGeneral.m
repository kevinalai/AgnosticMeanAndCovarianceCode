% Algorithm for estimating general covariance
% Assume mean of X's is 0

function [muHat, SigmaEst, centeredX] = agnosticCovarianceGeneral(X, eta)

    m = size(X, 1);
    n = size(X, 2);

    %muHat = agnosticMeanGeneral(X, eta);   
    muHat = zeros(1, n);
    
    tic;
    Z = X - repmat(muHat, m, 1);
    C = num2cell(Z, 2);
    centeredX = cellfun(@outerProdToVec, C, 'UniformOutput', 0);
    centeredX = cell2mat(centeredX);
    toc;
    fprintf('%d %d\n', size(centeredX));

    w = outRemBall(centeredX, eta);
 
    
    tic;
    SigmaEst = agnosticMeanGeneral(centeredX, eta);
    toc;
    SigmaEst = reshape(SigmaEst, [n n]);
end

%transform row vector v to outer product and then reshape into vector
function out = outerProdToVec(v)
    len = size(v, 2);
    V = v'*v;
    out = reshape(V,[1, len*len]);
end

