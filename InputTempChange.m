function re = InputTempChange(t, input)
    Vt0 = 1.5; %m3
    A = 1.33; %m2
    Cvpm = 2.34e-5;
    Pvp = 9.;
    F1ss = 1e-3; %m3/s
    F2ss = F1ss;
    C1ss = 1.; %kg/kg
    T1ss = 350.; %k
    ro = 1.e3; %kg/m3
    Cp = 1; %kj/kg/k
    Hrx = 2.e3; %j/kg
    k0 = 32.; %1/s
    R = 8.31; %J/k
    Ea = 42.*10.^3; %j
    Tc = 295.; %k
    UA = 5; %kj/k/s
    Fcmax = 90.; %L/s
    Pc = 9.; %psi
    C2ss =  C1ss.*0.2;
    g= 9.8;% m/s2
    %secondary parameters:
    Cvp = (Pvp - 3)./12.*Cvpm;
    Fc = (Pc - 3)./12.*Fcmax;
    F1 = F1ss;
    F2 = sqrt(input(1).*ro.*g) .* Cvp;
    Vt = input(1) .* A;
    C2 = input(2);
    T2 = input(3);
    T1 = T1ss .* 1.1;
    %-------------------------------------
    re(1,1) = (F1 - F2)./A;
    re(2,1) = F1.*ro.*C1ss./Vt - F2.*ro.*C2./Vt-k0.*exp(-Ea./R./T2).*ro.*C2;
    re(3,1) = F1.*T1./Vt - F2.*T2./Vt + UA.*(Tc - T2)./Vt./Cp./ro + Hrx.*k0.*exp(-Ea./R./T2).*C2./Cp; 
    

end

