[x,y,z]=cylinder(3);  %调用cylinder函数‘（）’内半径为3. 运行此命令后系统自动为x,y,z填充了数据
z(2,:)=10;      %设置矩阵Z的第二行数值全为2，即设置圆柱体高度
figure(1)            %绘制子图像（1，2，1）代表一行两列的第一个图像
surf(x,y,z,'FaceColor',[1,0,0]);       %使用surf功能将x,y,z的数据导入。FaceColor即设置圆柱体颜色，红色色号为[1,0,0]
daspect([1 1 1])                  %设置x,y,z坐标间距等长。
view(30,30)                     %设置图像显示角度
hold on                                %停止图像刷新
theta = linspace(0,2*pi,40);      %将一个圆周分为40份
X=3*cos(theta);                    %将cos值赋予x
Y=3*sin(theta);                     %将sin赋予Y
Z=ones(size(X))+1;                 %设置Z与X长度想等
fill3(X,Y,Z,[1,0,0]);                  %使用Fill3功能函数，填充XYZ所围成的区域，这个是顶盖
fill3(X,Y,Z-2,[1,0,0]);              %底盖
figure(2)
ezsurf('(2*cos(u))','2*sin(u)','v',[0,2*pi,0,2*pi])
figure(3)
[x,y]=meshgrid(0:1:10);
z=(x-5).^2+(y-5).^2;
pcolor(x,y,z)
shading interp;
colorbar