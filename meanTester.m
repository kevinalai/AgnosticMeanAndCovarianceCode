function [vals, vals2, vals3] = meanTester()

drange = [50:50:200 300:100:600];
vals = zeros(size(drange));
vals2 = zeros(size(drange));
vals3 = zeros(size(drange));

eta = .1;

for i = 1:size(drange,2)
    d = drange(i);
    m = 10*d;
    %X = noisyG(zeros(d,1), eye(d), 2*ones(d,1), eta, m);
    Y = mvnrnd(zeros(d,1), eye(d), m*(1-eta));
    Z = cauchyrnd(1, 1, eta*m, d);
    X = [Y;Z];
    vals(i) = norm(agnosticMeanG(X, eta));
    vals2(i) = norm(median(X));
    %vals3(i) = norm(mean(X));
end

plot(drange, vals, drange, vals2);%, drange, vals3);
legend show Location NorthEastOutside



end