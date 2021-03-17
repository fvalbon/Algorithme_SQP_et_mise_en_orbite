function [f,c] = probleme_etagement(m_e,V_p)
%% INPUT
% m_e : propellers (vector length 3)

%% OUTPUT
% f : value to minimize
% c : constraints
  
%% DESCRIPTION 
% Here is the problem function (PE)

    k_1 = 0.1101; 
    k_2 = 0.1532;
    k_3 = 0.2154;
    v_e = [2647.2, 2922.4, 4344.3];
    m_u = 1700;
  
    m_s1 = k_1*m_e(1);
    m_s2 = k_2*m_e(2);
    m_s3 = k_3*m_e(3);
    M_f(3) = m_u + m_s3;
    M_i(3) = M_f(3)+m_e(3);
    M_f(2) = M_i(3)+m_s2;
    M_i(2) = M_f(2)+m_e(2);
    M_f(1) = M_i(2)+m_s1;
    M_i(1) = M_f(1)+m_e(1);
    
    DV(1) = (v_e(1))*log(M_i(1)/M_f(1));
    DV(2) = (v_e(2))*log(M_i(2)/M_f(2));
    DV(3) = (v_e(3))*log(M_i(3)/M_f(3));
    DV = DV(1)+DV(2)+DV(3);
    
     f = M_i(1);
     c = DV - V_p;
end
