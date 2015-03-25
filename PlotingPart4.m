[t1, ans1] = ode45('InputTempChange', [0 3000], [0.7454, 0.1420, 590]);
plot(t1, ans1(:,2),'b');
title('Part4, C2-plot');
figure;
plot(t1, ans1(:,3),'b');
title('Part4, T2-plot');

