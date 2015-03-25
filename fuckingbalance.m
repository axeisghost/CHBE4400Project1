k0 = 32; Rc = 8.31; Ea = 42.*10.^3; Cvpm = 2.34e-5;
C1 = 1; Tc = 295; CP = 1.;
dHrxn = 2.*10.^3; T1 = 350;
F1 = 10.^(-3);
F2 = F1;
den = 10.^3; UA = 5;
Cvp = 0.5.*Cvpm;
h1 = (F2.^2)./((Cvp.^2).*den.*9.8);
Vt = 1.33 .* h1;
T2 = (250:900);
QR = Vt.*den.*dHrxn.*((k0.*C1)./((exp(Ea./(Rc.*T2)))+k0.*Vt./F1));
QE = -UA.*(Tc - T2)-F1.*den.*CP.*T1+F2.*den.*CP.*T2;
plot(T2, QR, 'b');
hold on;
plot(T2, QE, 'r');
title('Operating Temperature plot');
legend('Qreaction', 'Qexchange');
ylabel('Q(KJ/s)');
xlabel('T2(K)');
xlim([250 800]);
ylim([-100 2000]);
for ind = (1:length(T2))
    if (abs(QR(ind) - QE(ind)) <= 1)
        plot([T2(ind) T2(ind)], [-100 QR(ind)], 'k:');
        ans = T2(ind);
        C2 = C1./(1+((k0.*exp(-Ea./Rc./T2(ind)).*Vt./F1)));
    end
end
