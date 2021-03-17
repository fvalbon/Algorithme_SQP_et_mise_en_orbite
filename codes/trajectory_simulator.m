function [final_data,r,TIME]=trajectory_simulator(theta,m_e,M_e,RelTol,AbsTol)
%% function final_data.m
% This function returns the final state of Ariane and plot the launcher
% trajectory.
% r is the path of the launcher

    %% INPUT
    % theta : angle of incidence
    % m_e : propeller masses 
    % M_e : initial stage masses rocket at the separation time (see M1,M2,M3 in 'resolution_probleme_etagement.m')
    % RelTol : realative tolerance when using ODE45
    % AbsTol : absolute tolerance when using ODE45
    
    %% OUTPUT
    % final_data : state at final time [x(t_f),y(t_f),v_x(t_f),v_y(t_f),M_e(t_f)]
    
    %% Explanations of coordinates
    % We have :
    % launch's position : R(x(t),y(t)) 
    % speed's launcher : V(x(t),y(t))
    % launcher's mass M_e(t)
    
    %% VALUES 
    % tn : time when we drop the n-th stage of the rocket
    % y_init : initial values.
    % We solve the ODE and get a [0,t1] approximate solution vector and 
    % repeted the same process twice.
    k_3 = 0.2154;
    m_s3 = k_3*m_e(3);
    R_t = 6378137;
    M_0 = M_e(1);
    alpha=15;
    v_e=2600;
    
    theta_i=theta(2);
    parameters=[alpha;v_e;theta_i;M_e(1)];
    t1=m_e(1)*v_e/(alpha*M_e(1));
    y_init = [R_t;0;100*cos(theta(1));100*sin(theta(1));M_0];

    [T1,y1] = ode45(@(t,y) trajectory(t,y,parameters),[0 t1],y_init);
    %% Detach 1

    alpha=10;
    v_e=3000;
    theta_i=theta(3);
    parameters=[alpha;v_e;theta_i;M_e(2)];
    t2=t1+(m_e(2)*v_e/(alpha*M_e(2))); 

    y_init1 = y1(length(y1),:)';
    y_init1(5) = M_e(2);

    [T2,y2] = ode45(@(t,y) trajectory(t,y,parameters),[t1 t2],y_init1);
    %% Detach 2
    
    alpha=10;
    v_e=4400;
    theta_i=theta(4);
    t3=t2+(m_e(3)*v_e/(alpha*M_e(3)));
    parameters=[alpha;v_e;theta_i;M_e(3)];
    y_init2 = y2(length(y2),:)';
    y_init2(5) = M_e(3);
    
    [T3,y3] = ode45(@(t,y) trajectory(t,y,parameters),[t2 t3],y_init2);
    %% Detach 3
    
    y3(length(y3),:) = y3(length(y3),:) - m_s3*[0,0,0,0,1];
    TIME = [T1;T2;T3];
    r=[y1;y2;y3];    
    final_data=r(size(r,1),:)';

end

