%% TESTING FUNCTIONS INCLUDED IN THE PROJECT
% Here we run tests on the various functions that we are using for this
% project.
% Defining the bounds necessary to the coherence of our calculations
bounds = [ [-1e6,-1e6,-1e6];
            [1e6,1e6,1e6] ;   ];
            
%% Function sqp.m
%[x_star,f_star] = sqp([-1;2;1;-2;-2],@probleme,1,10,1, 0.000001, [0.000001;0.000001;0.000001;0.000001;0.000001],10000, bounds);

%% Function probleme_etagement.m
%probleme_etagement([145349,31215,4933])

%% Function resolution_probleme_etagement.m
%resolution_probleme_etagement(1500,V_p);
%[m_star,f_star] = sqp([1.4545e+05;3.1237e+04;7.9368e+03], @(x) probleme_etagement(x,6778137), 2, 100, 1, 0.0001,[0.01;0.01;0.01], 10000, bounds);

%% Function trajectory.m
%traj(0,[6378137;1;1;1;1],[1;1;1;1])

%% Function trajectory_simulator.m
%final_data = trajectory_simulator([-0.02;-0.0070;-0.150;-0.7],[1.4545e+05;3.1237e+04;7.9368e+03],[2.0883e+05;4.7369e+04;1.1346e+04],1e-3,1e-5);
%vitesse = norm(final_data(3:4),2);

%% Function main.m
clc; clear all;
R_t = 6378137;
R_c = R_t+400000;
main(-0.003,-0.055,-0.10,-0.3,[0;0;0],[0;0;0],1500,[0.10;0.15;0.20],[1;1;1;1;1],R_c,1,10,1e-3,1e-5);

%[x,fval,exitflag,output,lambda,grad,hessian] = fmincon(@(x) fun(x),x0,A,B,Aeq,Beq,lb,ub,'nonlcon',option)
