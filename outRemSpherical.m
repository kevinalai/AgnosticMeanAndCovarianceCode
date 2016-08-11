% Remove all points outside a radius r of the median
function [Y] = outRemSpherical(X,r)

m = size(X,1);
med = median(X);
Y = [];

%for i=1:m
%    if (norm(X(i,:) - med) < 2*r)
%        Y = [Y;X(i,:)];
%    end
%end

Z = X - repmat(med,m,1); 
T = sum(Z.^2,2); % matrix of squared distances from median
Y = X;
Y(T > 4*r*r, :) = []; % throw away points with large squared norm

end