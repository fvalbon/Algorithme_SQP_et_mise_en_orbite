
function [f,c]=speed_under_constraint(theta,m_e,M_e,R_c,RelTol,AbsTol)

%% Function speed_under_constraint.m
% This function modelizes the problem (PT).
% Values are normalized.
    
    mu = 3.986*10e14;
    V_c = sqrt(mu/R_c);
    d = trajectory_simulator(theta,m_e,M_e,RelTol,AbsTol);
    altitude=(R_c-norm(d(1:2),2))/R_c;
    inner_product=(d(1)*d(3)+d(2)*d(4))/(R_c*V_c);
    f=-norm(d(3:4),2)/V_c;
    c=[altitude;inner_product];
    
end
