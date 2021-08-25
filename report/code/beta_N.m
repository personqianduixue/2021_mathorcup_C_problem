N_qiangzhi =572;
deta = 0:90;
N_qiangzhi_deta = N_qiangzhi*(1-0.54*(cos(deg2rad(deta))).^2);
plot(deta,N_qiangzhi_deta,'b','LineWidth',2)
ylabel('服务器数量N')
xlabel('来流角度 /度')
title('服务器数量随海水来流角度的变化')
grid on
%legend('拟合结果','Location','best');