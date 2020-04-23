%% I. ��ջ�������
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
%% II. ѵ����/���Լ�����
%%
% 1. ��������
NIR=data;
a=ones(200,1);b=2*ones(200,1);c=3*ones(200,1);
d=4*ones(200,1);e=5*ones(200,1);
octane=[a;b;c;d;e];
%%
% 2. �������ѵ�����Ͳ��Լ�
temp = randperm(size(NIR,1));
% ѵ��������600������
P_train = NIR(temp(1:600),:)';
T_train = octane(temp(1:600),:)';
% ���Լ�����400������
P_test = NIR(temp(601:end),:)';
T_test = octane(temp(601:end),:)';
N = size(P_test,2);

%% III. ���ݹ�һ��
[p_train, ps_input] = mapminmax(P_train,0,1);
p_test = mapminmax('apply',P_test,ps_input);

[t_train, ps_output] = mapminmax(T_train,0,1);

%% IV. BP�����紴����ѵ�����������
%%
% 1. ��������
net = newff(p_train,t_train,15);

%%
% 2. ����ѵ������
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-2;
net.trainParam.lr =1;

%%
% 3. ѵ������
net = train(net,p_train,t_train);

%%
% 4. �������
t_sim = sim(net,p_test);

%%
% 5. ���ݷ���һ��
T_sim = mapminmax('reverse',t_sim,ps_output);

%% V. ��������
%%
% 1. ������error
error = abs(T_sim - T_test)./T_test;

%%
% 2. ����ϵ��R^2
R2 = (N * sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 

%%
% 3. ����Ա�
result = [T_test' T_sim' error']
figure
plot(1:N,T_test,'b:*',1:N,T_sim,'r-o')
legend('��ʵֵ','Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('����ֵ')
string = {'����ֵ����ʵֵ����Ա�';['R^2=' num2str(R2)]};
title(string)
X=[0 0.111111111 0.222222222 0.333333333 0.444444444 0.555555556 0.666666667 0.777777778 0.888888889 1];
Y=[0.00917 0.00612 0.00767 0.00898 0.00959 0.00798 0.00816 0.0096 0.00673 0.00813];
scatter(X,Y);
xlabel('ѧϰ��');
ylabel('���Ծ���-MSE');
title('���Ծ�����ѧϰ�ʱ仯��ϵ����');
m=[5 10 15 20 25 30];
n=[0.00985 0.00955 0.00641 0.00751 0.00867 0.00472];
scatter(m,n);
xlabel('������ڵ����');
ylabel('���Ծ���-MSE');
title('���Ծ�����������ڵ�����仯��ϵ����');
