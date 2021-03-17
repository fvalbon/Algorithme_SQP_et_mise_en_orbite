function F = fonction_merite(f,c,lambda,rho)
    L = f + lambda'*c;
    F = L + rho*norm(c,1);
end
    
    
    
