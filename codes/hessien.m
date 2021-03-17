function H = hessien(H,x_0,x_1,probleme,lambda,f_1,c_1,Gf_0,Gc_0,choice,h)
%% INPUT
% H : hessien at the previous iteration
% x_0 : value of the variable at the previous iteration
% x_1 : value of the variable at the current iteration
% problem : callback (function to minimize f and constraints c)
% lambda : solution lambda of the quadratic problem
% f_1 : value taken by the f in x_1
% c_1 : value taken by the f in x_1

% Gf_0 : gradient of f in x_0
% Gc_0 : gradient of c in x_0
% choice : 1 -> BDFS formula ; 2 -> SR1 formula
% h : step that allows to evaluate the differential of a function

%% OUTPUT
% H : hessian matrix
% Gf_1,Gc_1 : new gradient value (on x instead of x_0)

%% DESCRPTION
% Here is the formulae to calculate the hessien matrix of the problem callback functions (R^n->R function)

    d = x_1 - x_0;
    [Gf_1,Gc_1] = gradient(x_1,probleme,f_1,c_1,h);
    GL_0 =Gf_0 + Gc_0*lambda;
    GL_1 =Gf_1 + Gc_1*lambda;

    y = GL_1 - GL_0;
    if (choice == 1) 
        A1 = H*d;
        a2 = d'*A1;
        A3 = y*y';
        a4 = y'*d;
        
        if(a4>0)
            H=H+(A3/a4)-(A1*A1')/a2;
        end
    
    elseif (choice == 2) 
         A1 = y-H*d;
         a2 = d'*A1;
         if(a2>0)
             H = H+((A1*A1')/a2);
             sp = eig(H);
             min_sp=min(sp);
             if min_sp<=0
                H = H+(-min_sp+1)*eye(length(x_1));
             end    
         end
    
    else
       disp("Wrong choice");
    end
end
