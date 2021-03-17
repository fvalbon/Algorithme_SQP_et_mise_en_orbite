function [V_p,M_star,m_star,theta_star,it] =main(theta_init0,theta_init1,theta_init2,theta_init3,perturb1,perturb2,m_utile,indices_etages,rho,R_c,it_max,tol,RelTol,AbsTol)
%% Function main.m
% This function gives the optimal path and the optimal configuration of a space launcher.
% We iterate on the propelling sped until the %real speed V_p equals the target speed V_c.

    %% INPUT
    % theta_initn : initial values (they must be chosen carefully)
    % peturb1 : length 3 vector, used to observe SQP's "catching area"
    % perturb2:
    % m_utile : satellite's mass
    % rho : used to determine the weight of the constraint in the merite 
    % function
    % R_c : Targeted radius for the orbit
    % RelTol : relative tolerance when using ODE45
    % AbsTol : absolute tolerance when using ODE45
    % it_max : maximum number of iterations
    
    %% 1)- DATA
    
    bounds_ergol = [0,0,0;
              1e6,1e6,1e6];
    mu = 3.986e14;
    V_c = sqrt(mu/R_c);
    k_1 = indices_etages(1); 
    k_2 = indices_etages(2);
    k_3 = indices_etages(3);
    V_p = V_c;
    it = 0;
    delta = 0.2*V_c;
    bounds_angle = [-pi/2;pi/2];
    bounds_angle2 = [-pi/2,-pi/2; 
                    pi/2,pi/2];
    bounds_angle3 = [-pi/2,-pi/2,-pi/2;pi/2,pi/2,pi/2];
    bounds_angle4 = [-pi/2,-pi/2,-pi/2,-pi/2; pi/2,pi/2,pi/2,pi/2];
    M_star=[0;0;0];
    theta_star = [0;0;0;0];
    
    %% 2)- ITERATIONS UNTIL TARGET SPEED V_P 
    while(it<it_max && delta>tol)
        disp('ITERATION');
        it = it+1
        V_p = V_p + delta;
        [m_e1,m_e2,m_e3,M_0]=resolution_probleme_etagement(m_utile,V_p); 
        [m_star,f_star] = sqp([m_e1+perturb1(1);m_e2+perturb1(2);m_e3+perturb1(3)], @(x) probleme_etagement(x,V_p), 2, 100, 1, 0.0001,[0.01;0.01;0.01], 10000, bounds_ergol)
        m_s1 = k_1*m_star(1);
        m_s2 = k_2*m_star(2);
        m_s3 = k_3*m_star(3);
        M_f(3) = m_utile + m_s3;
        M_star(3) = M_f(3)+m_star(3);
        M_f(2) = M_star(3)+m_s2;
        M_star(2) = M_f(2)+m_star(2);
        M_f(1) = M_star(2)+m_s1;
        M_star(1) = M_f(1)+m_star(1);
                                       
        disp("'BALAYAGE' :")
        
        [theta_star(1:2),f_star] = sqp([theta_init0;theta_init1] ,@(theta) speed_under_constraint([theta(1);theta(2);theta_init2;theta_init3],m_star,M_star,R_c,RelTol,AbsTol),1,15,rho(3),1e-4,[0.00001;0.00001],100,bounds_angle2);
        
        disp('first optimization')
        theta_star(1:2)
        V_r = -f_star*(V_c)
        
        [theta_star(1:3),f_star] = sqp([theta_star(1);theta_star(2);theta_init2],@(theta) speed_under_constraint([theta(1);theta(2);theta(3);theta_init3],m_star,M_star,R_c,RelTol,AbsTol),1,15,rho(4),0.0001,[0.00001;0.00001;0.00001],100,bounds_angle3);
        
        disp('second optimization')
        theta_star(1:3)
        V_r = -f_star*(V_c)
        
        [theta_star(1:4),f_star] = sqp([theta_star(1);theta_star(2);theta_star(3);theta_init3],@(theta) speed_under_constraint([theta(1);theta(2);theta(3);theta(4)],m_star,M_star,R_c,RelTol,AbsTol),2,15,rho(5),0.0001,[0.00001;0.00001;0.00001;0.00001],100,bounds_angle4);
        
        disp('third optimization')
        theta_star
        V_r = -(V_c)*(f_star)
  
    end
    
    %% 3)- CONCLUSION : OPTIMAL PATH
    disp('CONCLUSION :')
    disp('optimals angles (rad)')
    theta_star
    disp('optimal speed (m/s)')
    V_r
    disp('optimals porpergols')
    m_star
    disp('otimals mass')
    M_star
    disp('number of iterations')
    it
    
    [d,r,time] = trajectory_simulator(theta_star,m_star,M_star,RelTol,AbsTol);
    
    figure(1)
    plot(r(:,2),r(:,1)-6378137*ones(length(r(:,1)),1));
    title ('optimal trajectory in the plan');
    xlabel("Earth's surface (m)")
    ylabel('altitude (m)')
    grid on
    
    figure(2)
    plot(time,r(:,3));
    title('TIME EVOLUTION OF OPTIMAL SPEED')
    xlabel('Time (seconds)')
    ylabel('Speed (m/s)')
    grid on

    figure(3)
    plot(time,r(:,4));
    title('TIME EVOLUTION OF OPTIMAL SPEED')
    xlabel('Time (seconds)')
    ylabel('Speed (m/s)')
    grid on
    
    figure(4)
    plot(time,r(:,5));
    title ("TIME EVOLUTION OF LAUNCHER'S MASS");
    xlabel('Time (seconds)')
    ylabel("Launcher's mass (kg)")
    grid on
end





