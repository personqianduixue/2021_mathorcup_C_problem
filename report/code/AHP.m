clc,clear 
load guiyi
a = [1,1,1;1,1,1;1,1,1];
b1=[];b2=[];b3=[];n1=3;n2=6;
for i=1:3 
   for j = 1:6
       for k = 1:6
           b = char(['b',int2str(i)]);
           eval([b,'(j,k)=guiyi(j,i)/guiyi(k,i);']);
       end
   end
end
ri=[0,0,0.58,0.90,1.12,1.24,1.32,1.41,1.45]; %一致性指标
[x,y]=eig(a); lamda=max(diag(y)); 
num=find(diag(y)==lamda);
w0=x(:,num)/sum(x(:,num)); 
cr0=(lamda-n1)/(n1-1)/ri(n1)
for i=1:n1
[x,y]=eig(eval(char(['b',int2str(i)]))); 
lamda=max(diag(y));
num=find(diag(y)==lamda);
w1(:,i)=x(:,num)/sum(x(:,num))
cr1(i)=(lamda-n2)/(n2-1)/ri(n2);
end
cr1, ts=w1*w0, cr=cr1*w0
 %以下是一致性检验

if cr<0.10
 disp('此矩阵的一致性可以接受!');
 disp('CR=');disp(cr);
else disp('此矩阵的一致性验证失败，请重新进行评分!');
end