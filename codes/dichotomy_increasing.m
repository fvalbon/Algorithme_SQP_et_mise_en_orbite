function [x,last_step]=dichotomy_increasing(x_min,x_max,tol,fun)
%% DESCRIPTION
% DICHOTOMY_INCREASING use the bisection method to return the zero of
% a non_decreasing function

% x_max and x_min :  the intial bounds
% tol : tolerance parameter
% fun : callback of the function whose zeros is searched
% care must be taken : f(x_min)<0 and f(x_max)>0

    x=(x_max+x_min)/2;
    f_x=fun(x);
    last_step=x_max-x;
    while (abs(f_x)>tol)
        if (f_x<0)
            x_min=x;
            f_xmin=f_x;

            x=(x_max+x_min)/2;
            f_x=fun(x);

            last_step=x_max-x;
        else
            x_max=x;
            f_xmax=f_x;

            x=(x_max+x_min)/2;
            f_x=fun(x);

            last_step=x-x_min;
        end

    end
end
