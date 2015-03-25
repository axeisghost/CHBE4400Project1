[t1, ans1] = ode45('FlowRateChange', [0 1000], [0.7454, 0.1420, 590]);
plot(t1, ans1(:,2),'b');
title('Part3, C2-plot');
figure;
plot(t1, ans1(:,3),'b');
title('Part3, T2-plot');
figure;
plot(t1, ans1(:,1),'b');
title('Part3, h-plot');

