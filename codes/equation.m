function[y]=equation(x,v_e1,v_e2,v_e3,omega_1,omega_2,omega_3,V_p) 
%% DESCRIPTION
% In 'probleme_etagement.m' we must find the zeros of this function (to solve the one dimensional problem)
% x : variable (in the problem it is x_3)
% other parameters : parameters from the problem (adjustable)

%% OUTPUT

    y = v_e1*log(-(v_e3*(1-omega_3*x))/(omega_1*v_e1)+1/omega_1)+v_e2*log(-(v_e3*(1-omega_3*x))/(omega_2*v_e2)+1/omega_2)+v_e3*log(x) - V_p;
    
end

