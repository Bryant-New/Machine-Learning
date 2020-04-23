%% I. 清空环境变量
clear all
clc
Sigma = [1, 0; 0, 1];
mu1 = [1, -1];
x1 = mvnrnd(mu1, Sigma, 200); mu2 = [5, -4];
x2 = mvnrnd(mu2, Sigma, 200); mu3 = [1, 4];
x3 = mvnrnd(mu3, Sigma, 200); mu4 = [6, 4];
x4 = mvnrnd(mu4, Sigma, 200); mu5 = [7, 0.0];
x5 = mvnrnd(mu5, Sigma, 200);
data=[x1;x2;x3;x4;x5];
%% II. 训练集/测试集产生
%%
% 1. 导入数据
NIR=data;
a=ones(200,1);b=2*ones(200,1);c=3*ones(200,1);
d=4*ones(200,1);e=5*ones(200,1);
octane=[a;b;c;d;e];
%%
% 2. 随机产生训练集和测试集
temp = randperm(size(NIR,1));
% 训练集——600个样本
P_train = NIR(temp(1:600),:)';
T_train = octane(temp(1:600),:)';
% 测试集——400个样本
P_test = NIR(temp(601:end),:)';
T_test = octane(temp(601:end),:)';
N = size(P_test,2);

%% III. 数据归一化
[p_train, ps_input] = mapminmax(P_train,0,1);
p_test = mapminmax('apply',P_test,ps_input);

[t_train, ps_output] = mapminmax(T_train,0,1);

%% IV. BP神经网络创建、训练及仿真测试
%%
% 1. 创建网络
net = newff(p_train,t_train,15);

%%
% 2. 设置训练参数
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-2;
net.trainParam.lr =1;

%%
% 3. 训练网络
net = train(net,p_train,t_train);

%%
% 4. 仿真测试
t_sim = sim(net,p_test);

%%
% 5. 数据反归一化
T_sim = mapminmax('reverse',t_sim,ps_output);

%% V. 性能评价
%%
% 1. 相对误差error
error = abs(T_sim - T_test)./T_test;

%%
% 2. 决定系数R^2
R2 = (N * sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 

%%
% 3. 结果对比
result = [T_test' T_sim' error']
figure
plot(1:N,T_test,'b:*',1:N,T_sim,'r-o')
legend('真实值','预测值')
xlabel('预测样本')
ylabel('分类值')
string = {'测试值与真实值结果对比';['R^2=' num2str(R2)]};
title(string)
X=[0 0.111111111 0.222222222 0.333333333 0.444444444 0.555555556 0.666666667 0.777777778 0.888888889 1];
Y=[0.00917 0.00612 0.00767 0.00898 0.00959 0.00798 0.00816 0.0096 0.00673 0.00813];
scatter(X,Y);
xlabel('学习率');
ylabel('测试精度-MSE');
title('测试精度随学习率变化关系曲线');
m=[5 10 15 20 25 30];
n=[0.00985 0.00955 0.00641 0.00751 0.00867 0.00472];
scatter(m,n);
xlabel('隐含层节点个数');
ylabel('测试精度-MSE');
title('测试精度随隐含层节点个数变化关系曲线');
