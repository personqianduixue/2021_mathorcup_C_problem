clear 
clc
tr=20;to=80;h1=10:10:200;h2=200;d1=0.9;d2=1;k=80;
ts=tr+(to-tr)./(h2*d2*(1./h1./d1+0.5./k*log(d2./d1))+1);
plot(h1,ts,'r','LineWidth',2)
ylabel('圆柱体表面温度T_s \circ C')
xlabel('h_1 W/(m^2K)')
title('圆柱体表面温度T_s随传热系数h_1的变化')