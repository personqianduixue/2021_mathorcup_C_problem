
clc
%load waterchanshu
global waterchanshu
To = 80;%圆柱体中心温度
Tr = 0:25;%海水温度
L = 1;%特征长度
U = 1;%流速
S = 12*pi;%表面积
P = 500;%功率
H2 = 100:10:10000;
h1=100;d1=0.9;d2=1;k2=80;

grall=[];
hall=[];
nall=[];
Trall=[];
for tr = Tr
    for h2 = H2
        ts = findTs(To,tr,h1,h2,d1,d2,k2);
        Tm = round((ts+tr)/2);%定性温度
        v = waterchanshu(Tm+1,5);
        pr = Pr(Tm);
        re = Re(u,L,v);
        gr = Gr(ts,tr,L,v);
        ra = Ra(gr,pr);
        nu = Nu_zhiran_jianhua(ra);
        k = waterchanshu(Tm+1,4);%导热系数
        h = k*nu/L; %传热系数

        if abs(h2-h)<20
            chazhi = abs(h2-h);
            Trall = [Trall,tr];
            n = N(nu,k,ts,tr,S,P,L)
            nall =[nall,n];
            break;
        end
    end

end
nall
scatter(Trall,nall,'*');hold on;
p = polyfit(Trall,nall,1);
yi = polyval(p,Tr);
plot(Tr,yi, 'LineWidth',1.5)
ylabel('服务器数量N')
xlabel('海水温度/摄氏度')
title('服务器数量随海水温度的变化')
grid on
legend('散点', '拟合结果','Location','best');

% %打开图，设置左右y轴属性
% fig = figure;
% left_color = [0 0 0];
% right_color = [0 0 0];
% set(fig,'defaultAxesColorOrder',[left_color; right_color]);
% %激活左侧
% yyaxis left
% plot(Ts, nall,'r', 'LineWidth',2);   
% hold on
% ylabel('服务器数量N')
% %激活右侧
% yyaxis right
% plot(Ts, hall,'b', 'LineWidth',2);
% ylabel('传热系数h W/m^2 \circ C')
% xlabel('圆柱体表面允许最大温度/\circ C')
% title('N和h随表面允许最大温度的变化(自然对流)')
% legend('服务器数量N', '传热系数h','Location','best');
% %画网格
% grid on










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


function n = N(nu,k,Ts,Tr,S,P,L)
    n = round(nu*k*(Ts-Tr)*S/P/L);
end

function ts = findTs(to,tr,h1,h2,d1,d2,k2)
    ts = tr+(to-tr)./(h2*d2*(1./h1./d1+0.5./k2*log(d2./d1))+1);
    ts = round(ts);
end







