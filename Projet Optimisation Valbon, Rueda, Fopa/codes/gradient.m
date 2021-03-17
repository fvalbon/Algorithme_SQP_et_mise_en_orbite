function[Gf_0, Gc_0]= gradient(x_0,probleme,f,c,h)
%% DESCRIPTION
% This script computes the gradient (by finite difference method) of the
% function probleme (callback here)%in x_0, using a variation parameter of h (vector of size)
% f and c are the value (already computed in SQP) of probleme in x_0

    n = length(x_0);
    m = length(c);
    Gf_0=zeros(n,1); 
    Gc_0=zeros(n,m);

    for i = 1:n
        x_h=x_0;  
        x_h(i)=x_0(i)+h(i);
        [f_h,c_h] = probleme(x_h);
        Gf_0(i) = (f_h-f)/h(i);
        for j = 1:m
            Gc_0(i,j)=(c_h(j)-c(j))/h(i);
        end
    end
end
   
        
      
        
        
	
