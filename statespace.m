%project1 parameters
A = 1.33; %m2
Cvpm = 2.34e-5;
Pvp = 9;
F1ss = 1e-3; %m3/s
F2ss = F1ss;
C1ss = 1; %kg/kg
T1ss = 350; %k
ro = 1e3; %kg/m3
Cp = 1;
Hrx = 2e3; %kj/kg
k0 = 32; %1/s
R = 8.31./1000; %kJ/k
Ea = 42; %kj
Tcss = 295; %k
UA = 5; %kj/k/s
Fcmax = 90; %L/s
Pc = 9; %psi
T2ss = 590; %from 'fucking balance'
g= 9.8;% m/s2

%secondary parameters:
Cvp = (Pvp - 3)./12.*Cvpm;
Fc = (Pc - 3)./12.*Fcmax;
hss = (F2ss.^2)./((Cvp.^2).*ro.*g);
Vtss = A.*hss;
C2ss=C1ss./(1+(k0.*exp(-Ea./(R.*T2ss)).*Vtss)./F1ss);
%State space:
% x = [T2p;C2p;F2p]
% xdot = [dT2p/dt;dC2p/dt;dF2p/dt]

a11=-Cvp.*sqrt(ro.*g)./sqrt(hss)+UA./(ro.*Cp.*A.*hss)-Hrx.*k0.*Ea.*exp(-Ea./(R.*T2ss)).*C2ss./ ...
    (Cp.*R.*T2ss); %T2'
a12=Hrx.*k0./Cp.*exp(-Ea./(R.*T2ss)); %C2'
a13=-T1ss.*F1ss./(A.*(hss.^2))+Cvp.*sqrt(ro.*g).*T2ss./(2.*(hss.^(1.5)))+UA.*Tcss./(ro.*Cp.*A.*(hss.^2))...
    -UA.*T2ss./(ro.*Cp.*A.*(hss.^2)); %h'
a21=k0.*Ea./(R.*T2ss).*exp(-Ea./(R.*T2ss)).*C2ss; %T2' for dc2'/dt
a22=-Cvp.*sqrt(ro.*g.*hss)./(hss.*A)-k0.*exp(-Ea./(R.*T2ss)); %C2'
a23=C2ss.*Cvp.*sqrt(ro.*g)./(2.*A.*(hss.^1.5))-F1ss.*C1ss./(hss.^2.*A); %h'
a31=0;%T2' for dh'/dt
a32=0; %C2'
a33=-Cvp.*sqrt(ro.*g)./(2.*A.*sqrt(hss)); %h'

%Matrix A:
A1=[a11, a12, a13; a21, a22, a23; a31, a32, a33];

% U = [T1p;C1p;F1p;Tcp];
b11=F1ss./(A.*hss); %T1p for dT2p/dt
b12=0;  %C1p
b13=T1ss./(A.*hss);  %F1p
b14=-UA./(ro.*Cp.*A.*hss);  %Tcp
b21=0;%T1p for dC2p/dt
b22=F1ss./(A.*hss);%C1p
b23=C1ss./(A.*hss);%F1p
b24=0;%Tcp
b31=0;%T1p for dF2p/dt
b32=0;%C1p
b33=1./A;%F1p
b34=0;%Tcp

%Matrix B:
B = [b11,b12,b13,b14;b21,b22,b23,b24;b31,b32,b33,b34];

%Selector matrix C:
C = [1 1 1;1 1 1;1 1 1; 1 1 1];

syms s;
%Identity matrix
I = eye(3,3);
%Transfer function
G = vpa(inv((s*I-A1))*B,3);

%test response here:
%U = [10; 0; 0; 0];
%Y = G*U;
