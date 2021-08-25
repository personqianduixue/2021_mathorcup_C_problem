clear 
clc
tr=20;to=80;h1=10;h2=100;d1=0.9;d2=1;k=10:500;
ts=tr+(to-tr)./(h2*d2*(1./h1./d1+0.5./k*log(d2./d1))+1);
plot(k,ts,'r','LineWidth',2)
ylabel('圆柱体表面温度T_s \circ C')
xlabel('k W/(mK)')
title('圆柱体表面温度T_s随材料导热系数k的变化')