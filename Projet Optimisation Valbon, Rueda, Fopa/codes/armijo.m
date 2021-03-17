function [x_1] = armijo(x_0,probleme,f,c,Gf,lambda,d,rho,h)
%% DESCRIPTION
% 'armijo.m' helps us to find the optimal direction for our minimization
% problem.

    s = 1;
    F = fonction_merite(f,c,lambda,rho);
    [f_s,c_s] = probleme(x_0 + s*d);
    F_s = fonction_merite(f_s,c_s,lambda, rho); 
    dF = Gf'*d-rho*norm(c,1);
    assert(dF<0,"le d doit être une direction de descente");

    while(F_s>=F + 0.1*s*dF)&&(s>0)
        s = s/2;
        [f_s,c_s] = probleme(x_0 + s*d);
        F_s = fonction_merite(f_s,c_s,lambda, rho); 
    end
    x_1 = x_0 + s*d;
    
        
