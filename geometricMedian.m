function x = geometricMedian(X)


d = size(X,2);
N = length(X);

x = mean(X);
w = ones(N,1);

iters = 50;
prog = zeros(iters,1);

for i=1:iters
    
Y = bsxfun(@minus,X,x);
Y = Y.^2;

w1 = sum(Y,2); w1 = sqrt(w1);
prog(i) = sum(w1);
w1 = w1.^-1;

w = w1/sum(w1); 

x = sum(bsxfun(@times,X,w));


end


plot(prog,'r*')
