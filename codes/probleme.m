function [f,c] = probleme(x)
%% DESCRIPTION
    % This function is a mere equation of the problem
    f = (x(1)-1)^2+(x(1)-x(2))^2+(x(2)-x(3))^3+(x(3)-x(4))^4+(x(4)-x(5))^4;
    c = [x(1)+x(2)^2+x(3)^2-3*sqrt(2)-2;x(2)-x(3)^2+x(4)-2*sqrt(2)+2;x(1)*x(5)-2];
end
