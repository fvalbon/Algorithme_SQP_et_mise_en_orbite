function[f_y]=trajectory(t,y,parameters)
%% DESCRIPTION
% Trajectory modelizes the differential equation which rules the trajectory
% It will be used in ODE45.

% parameters = [initial acceleration;ejection speed;parameter angle;initial
% stage mass]
% R_dot : derivative of the position with respect to the time
% V_dot : derivative of the speed with respect to the time
% M_dot : derivative of the mass with respect to the time

    rho_0 = 1.225;
    mu = 3.986e14;
    c=0.1;
    H=7e3;
    R_t=6378137;

    R = y(1:2);
    V = y(3:4);
    M = y(5);
    W=-mu*M*(1/(norm(R,2)^3))*R;
    rho=rho_0*exp(-(norm(R,2)-R_t)/H);
    D=-c*rho*norm(V,2)*V;
    T_value=parameters(1)*parameters(4);

    e_r=(1.0/norm(R,2))*R;
    e_h=(1.0/norm(R,2))*[-R(2);R(1)];

    gamma=asin((R'*V)/(norm(R,2)*norm(V,2)));
    u=e_h*cos(parameters(3)+gamma)+e_r*sin(parameters(3)+gamma);

    q=(T_value/parameters(2));
    T=T_value*u;
    R_dot = V;
    V_dot = (T+W+D)/M;
    M_dot = -q;
    f_y  = [R_dot;V_dot;M_dot];

end
