function final_data=trajectory_simulator(theta,m_e,M_e,RelTol,AbsTol)
%% INPUT
% m_e masse d'ergols
% M_e masse du lanceur à l'allumage de l'étage j (voir M1,M2,M3 dans resolution_probleme_14.m)
R_t = 6378137;
M_0 = M_e(1);
alpha=15;
v_e=2600;
theta_i=theta(2);
parameters=[alpha;v_e;theta_i;m_e(1)];
t1=m_e(1)*v_e/(alpha*M_e(1));
y_init = [R_t;0;100*cos(theta(1));10*sin(theta(2));M_0];

option = odeset('RelTol',y_init*RelTol, 'AbsTol',y_init*AbsTol)


[t,y1] = ode45(@(t,y) trajectory(t,y,parameters),[0 t1],y_init);
disp('Detach 1');
size(y1);
alpha=10;
v_e=3000;
theta_i=theta(3);
parameters=[alpha;v_e;theta_i;m_e(2)];
t2=t1+(m_e(2)*v_e/(alpha*M_e(2))) ;
y_init1 = y1(length(y1),:)';
y_init1(5) = y_init1(5)-m_e(1);

option = odeset('RelTol',y_init*RelTol, 'AbsTol',y_init*AbsTol)

[t,y2] = ode45(@(t,y) trajectory(t,y,parameters),[t1 t2],y1(length(y1),:)');
disp('Detach 2');
alpha=10;
v_e=4400;
theta_i=theta(4);
t3=t2+(m_e(3)*v_e/(alpha*M_e(3)));
parameters=[alpha;v_e;theta_i;m_e(3)];

option = odeset('RelTol',y_init*RelTol, 'AbsTol',y_init*AbsTol)

[t,y3] = ode45(@(t,y) trajectory(t,y,parameters),[t2 t3],y2(length(y2),:)');
disp('Detach 3');


r=[y1;y2;y3]; %r is the path
plot(r(:,1),r(:,2));


final_data=r(size(r,1),:)';
