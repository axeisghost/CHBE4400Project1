[t1, ans1] = ode45('CoolingTempChange', [0 3000], [0.7454, 0.1420, 590]);
plot(t1, ans1(:,2),'b');
title('Part5, C2-plot');
figure;
plot(t1, ans1(:,3),'b');
title('Part5, T2-plot');