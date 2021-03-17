function[m_e1,m_e2,m_e3,M_0]=resolution_probleme_etagement(m_u,V_p)
%% Function resolution_probleme_etagement.m
% This function solves (PE) with an analytic method.
% dichotomy_increasing() function helps us to find initial conditions for 'secante.m' algorithm.

    % Initial parameters
    k_1 = 0.1101;
    k_2 = 0.1532;
    k_3 = 0.2154;
    v_e1 = 2647.2;
    v_e2 = 2922;
    v_e3 = 4344.3;
    omega_1=k_1/(1+k_1);
    omega_2=k_2/(1+k_2);  
    omega_3=k_3/(1+k_3);
    
    % Here we use dichotomy_increasing()
    [x_0,last_step] = dichotomy_increasing(3,1000,1000,@(x) equation(x,v_e1,v_e2,v_e3,omega_1,omega_2,omega_3,V_p));
    x_1 = x_0-last_step*0.01;
    
    % Continuation of the algorithm after finding the initial conditions
    % with dichotomy_increasing()
    it_max = 100;
    epsilon = 0.001;
    
    % Here we call secante.m function
    x_3 = secante(@(x) equation(x,v_e1,v_e2,v_e3,omega_1,omega_2,omega_3,V_p),x_0,x_1,it_max,epsilon);
    
    cste = v_e3*(1-omega_3*x_3);
    x_2 = (1-(cste/v_e2))/omega_2;
    x_1 = (1-(cste/v_e1))/omega_1;
    f_x = -(((1+k_1)/x_1)-k_1)*(((1+k_2)/x_2)-k_2)*(((1+k_3)/x_3)-k_3);
    M_0 = -m_u/f_x;
    m_e1 = M_0*(1-(1/x_1));
    M_1 = M_0-k_1*m_e1-m_e1;
    m_e2 = M_1*(1-(1/x_2));
    M_2 = M_1-k_2*m_e2-m_e2;
    m_e3 = M_2*(1-(1/x_3));
    
end 

