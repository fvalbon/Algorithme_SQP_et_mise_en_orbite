function [d_QP,l_QP] = resolution_QP(H,x_0,c_0,Gf_0,Gc_0,h)
%% function resolution_QP.m
% This function solves the quadratic problem through SQP method
    if(c_0 == 0)
        l_QP = 0;
        d_QP = -inv(H)*Gf_0;
    else
        l_QP = -inv(Gc_0'*inv(H)*Gc_0) * (Gc_0'*inv(H)*Gf_0 - c_0);
        d_QP = -inv(H)*(Gc_0*l_QP + Gf_0);
    end
        

end
