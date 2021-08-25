clear 
clc
%load waterchanshu
global waterchanshu
Ts = 21:60;%圆柱体表面温度
Tr = 20;%海水温度
L = 1;%特征长度
u = 1;%流速
S = 12*pi;%表面积
P = 500;%功率

grall=[];
hall=[];
nall=[];
for ts = Ts
   
    Tm = floor((ts+Tr)/2);%定性温度
    v = waterchanshu(Tm+1,5);
    pr = Pr(Tm);
    prr = Pr(Tr);
    prs = Pr(ts);
    re = Re(u,L,v);
    gr = Gr(ts,Tr,L,v);
    grall = [grall,gr];
    ra = Ra(gr,pr);
    nu = Nu_qiangzhi(re,prr,prs);
    % nu = Nu_zhiran_jianhua(ra);
    k = waterchanshu(Tm+1,4);%导热系数
    h = k*nu/L; %传热系数
    hall = [hall,h];
    n = N(nu,k,ts,Tr,S,P);
    nall = [nall,n];

end
% figure(1)
% plot(Ts,nall,'r',Ts,hall,'b','LineWidth',2),grid on
% title('服务器最大数量随表面允许最大温度的变化')
% xlabel('圆柱体表面允许最大温度/\circ C')
% ylabel('服务器最大数量')
%打开图，设置左右y轴属性
fig = figure;
left_color = [0 0 0];
right_color = [0 0 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
%激活左侧
yyaxis left
plot(Ts, nall,'r', 'LineWidth',2);   
hold on
ylabel('服务器数量N')
%激活右侧
yyaxis right
plot(Ts, hall,'b', 'LineWidth',2);
ylabel('传热系数h W/m^2 \circ C')
xlabel('圆柱体表面允许最大温度/\circ C')
title('N和h随表面允许最大温度的变化(强制对流)')
legend('服务器数量N', '传热系数h','Location','best');
%画网格
grid on










function re = Re(u,L,v)
    re = u*L/v;
end

function gr = Gr(Ts,Tr,L,v)
    global waterchanshu
    g = 9.8;
    %beta = 2/(Ts+Tr+273.15*2);
    %beta = waterchanshu((Ts+Tr)/2+1,8);
    beta = 0.21*10^(-3);
    gr = g*beta*(Ts-Tr)*L^3/(v^2);
end

function ra = Ra(gr,pr)
    ra = gr*pr;
end

function nu = Nu_zhiran(ra,pr)
    nu = (0.6+0.387*ra^(1/6)/((1+(0.559/pr)^(9/16)))^(8/27))^2;
end

function nu = Nu_zhiran_jianhua(ra)
    nu = 0.53*ra^0.25;
end

function nu = Nu_qiangzhi(re,prr,prs)
    if re>5 && re<10^3
        C=0.5;
        n=0.5;
    elseif re>10^3 && re<2*10^5
        C=0.26;
        n=0.6;
    else 
        C=0.023;
        n=0.8;
    end
    nu = C*re^n*prr^0.37*(prr/prs)^0.25;
end

function pr = Pr(Tr)
    global waterchanshu
    pr = waterchanshu(Tr+1,7);
end


function n = N(nu,k,Ts,Tr,S,P)
    n = floor(nu*k*(Ts-Tr)*S/P);
end








