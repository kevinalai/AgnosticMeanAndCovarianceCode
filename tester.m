function [est, sMean, sMed] = tester(eta, m)

    numVals = 10;
    range = ceil(linspace(100, 10000, numVals));
    sMean = zeros(numVals, 1);
    sMed = zeros(numVals, 1);
    est = zeros(numVals, 1);
    
    for i=1:numVals
        n = range(i);
        fprintf('Working on i=%d, n=%d\n',i, n);
        
        mu = zeros(n, 1);
        I = eye(n);
        z = 100*ones(n, 1);
        X = noisyG(mu, I, z, eta, m);
        sMean(i) = norm(mean(X));
        sMed(i) = norm(median(X));
        est(i) = norm(agnosticMeanG(X));
    end
    
    plot(range, est, range, sMean, range, sMed);
end