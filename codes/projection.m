function [y] = projection(x,bounds)
%% DESCRIPTION
% This is the projection on the pavage bounds [a,b]x..x[c,d]
% format of bounds : [[a,...,c];[b,...,d]]
    n = size(bounds,2);
    y =x;
    for i = 1:n
        if (x(i)<bounds(1,i))
            y(i)=bounds(1,i);
        end
        if (x(i)>bounds(2,i))
            y(i)=bounds(2,i);
        end
    end
end
