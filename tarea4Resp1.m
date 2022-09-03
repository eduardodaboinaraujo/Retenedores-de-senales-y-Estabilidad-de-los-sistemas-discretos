clear 
clc 
close all

To=0.05;
t=0:0.1:7;
k=0:To:7;

y = 1.5*exp(-1.*t)-.25-1.25*exp(-2.*t);
yk = 1.5*exp(-1.*k)-.25-1.25*exp(-2.*k);

y2=(5.*exp(-2.*t))/8 - (3.*exp(-t))/2 - t/4 + (heaviside(t - 1).*(t/2 + exp(1 - t) - exp(2 - 2.*t)/4 - 5/4))/2 - heaviside(t - 1).*(exp(2 - 2.*t)/2 - exp(1 - t) + 1/2) + 7/8;
yk2=(5.*exp(-2.*k))/8 - (3.*exp(-k))/2 - k/4 + (heaviside(k - 1).*(k/2 + exp(1 - k) - exp(2 - 2.*k)/4 - 5/4))/2 - heaviside(k - 1).*(exp(2 - 2.*k)/2 - exp(1 - k) + 1/2) + 7/8;

figure(1)
plot(t,y)
hold on
stem(k,yk,'*r')
title('Sistema LIT');
legend('Continua','Discreto');
grid on

figure(2)
plot(t,y2)
hold on
stem(k,yk2,'*r')
title('Sistema LIT con Retenedor');
legend('Continua','Discreto');
grid on

figure(3)
plot(t,y,'b')
hold on
stem(k,yk,'*r')
hold on
plot(t,y2,'k')
hold on
stem(k,yk2,'*g')
title('Sistema LIT sin y con Retenedor');
legend('Continua sin retenedor','Discreto sin retenedor','Continua con retenedor','Discreto con retenedor');
grid on