function [x]=secante(fun,x_0,x_1,it_max,epsilon)
%% INPUT
% fun : callback to solve (find its zero)
% x_0 : first initializer
% x_1 : second initializer
% it_max : number maximum of iteration (sometimes it doesn't converge but if it does,
%          the rate of converge is very fast)
% epsilon : tolerance parameter

%% Algorithm of secant method
    % Initialization
    k_1 = 0.10;
    k_2 = 0.15;
    k_3 = 0.20;
    v_e1 = 2600;
    v_e2 = 3000;
    v_e3 = 4400;
    V_p = 11527;
    omega_1=k_1/(1+k_1);
    omega_2=k_2/(1+k_2);  
    omega_3=k_3/(1+k_3);
    it=0;
    x=x_1;
    f_0=fun(x_0);
    max_ = max((1-(v_e1/v_e3))/omega_3,(1-(v_e2/v_e3))/omega_3);
    
    % Algortihm
    if x_0<=epsilon
        x=x_0;
    end
    f_1=fun(x_1);
    while (it<it_max && abs(f_1)>epsilon)
        it=it+1;
        x=x_1-((x_1-x_0)/(f_1-f_0))*f_1;
        x_0=x_1;
        x_1=x;
        assert(x_1>max_,"negative value in log");
        f_0=f_1;
        f_1=fun(x);
    end
    assert(x>0,'x cannot be negative');
end
