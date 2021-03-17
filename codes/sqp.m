function [x_star,f_star,Gf_1,iteration] = sqp(x, probleme, choice, re_init_hessian, rho, epsillon,h_init, max_iteration,bounds)
%% SQP minimize a non-linear function with non-linear constraints
    % Parameters :
    % x := initialization value
    % problem := callback (function to minimize f and constraints c)
    % max_iteration := maximum number of iterations 
    % epsillon := precison of the solution point
    % rho := penalisation
    % x := initial point
    % h := precision parameter 
    % re_init_hessian := number of iteration before the "re-initialization" of the
    % hessian matrix
    % bounds : bounds
    
%% Initialization
    iteration = 0;          % iteration : number of iterations before the algorithm stop
    n = length(x);          % n : dimension of x 
    H = eye(n);             %H : hessian matrix
    diff = epsillon + 1;    %indicates the norm of the difference between x_{k+1} and x_k.
    assert(re_init_hessian >= 10, "the parameter re_init_hessian must be incresed (>=9)");
    
%% Algorithm
    while((norm(diff,1)>epsillon) && (iteration < max_iteration))
        for i=1:n
           h(i)=x(i)*h_init(i);
        end
        
        iteration = iteration + 1; 
        x_0 = x;
        [f_0,c_0] = probleme(x_0);
        [Gf_0,Gc_0] = gradient(x_0,probleme,f_0,c_0,h);
        [d,lambda] = resolution_QP(H,x_0,c_0,Gf_0,Gc_0,h);
        [f_d,c_d] = probleme(x_0 + d);
        dF = Gf_0'*d-rho*norm(c_0,1);
        count = 0; 
        %count : count = 1 when hessian matrix was already re-initialized at identity
        %and dF is alway >=0
        
        if fonction_merite(f_d, c_d, lambda, rho)<fonction_merite(f_0,c_0,lambda, rho)
            x = projection(x + d,bounds);
            count = 0;
        else
            if (dF<0)&&(mod(iteration,re_init_hessian)~=0)
                x = armijo(x,probleme,f_0,c_0,Gf_0,lambda,d,rho,h);
                x = projection(x,bounds);
                count = 0;
            elseif (dF>0)&&(count < 1)&&(mod(iteration,re_init_hessian)~=0)
                H = eye(n);
                count = count + 1;
            elseif (dF>0)&&(count >= 1)&&(mod(iteration,re_init_hessian)~=0)
                rho = 2*rho;
            elseif (mod(iteration,re_init_hessian)==0)
                H = eye(n);
                count = 0;
            end
        end
        
        [f_1,c_1] = probleme(x);
        [Gf_1,Gc_1] = gradient(x,probleme,f_1,c_1,h);
        H = hessien(H,x_0,x,probleme,lambda,f_1,c_1,Gf_0,Gc_0,choice,h);
        diff = x - x_0;
    end
    
    disp(iteration);
    x_star = x;
    f_star = probleme(x);
    
    if (norm(c_0,2)>10)
        disp('constraints are not respected')
    end

end   
