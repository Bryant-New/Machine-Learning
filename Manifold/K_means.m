function  K_means 
Sigma = [1, 0; 0, 1];
mu1 = [1, -1];
x1 = mvnrnd(mu1, Sigma, 200); mu2 = [5, -4];
x2 = mvnrnd(mu2, Sigma, 200); mu3 = [1, 4];
x3 = mvnrnd(mu3, Sigma, 200); mu4 = [6, 4];
x4 = mvnrnd(mu4, Sigma, 200); mu5 = [7, 0.0];
x5 = mvnrnd(mu5, Sigma, 200);
plot(x1(:,1), x1(:,2), 'r.'); hold on;
plot(x2(:,1), x2(:,2), 'b.');
plot(x3(:,1), x3(:,2), 'k.');
plot(x4(:,1), x4(:,2), 'g.');
plot(x5(:,1), x5(:,2), 'm.');
data=[x1;x2;x3;x4;x5];% 数据聚类
[idx,ctr]=k_means(data,5,1000);
[m,n]=size(idx);
% 显示聚类后的结果
figure();
hold on;
for i=1:m
    if idx(i,3)==1
        plot(idx(i,1),idx(i,2),'r.','MarkerSize',12);
    elseif idx(i,3)==2
        plot(idx(i,1),idx(i,2),'b.','MarkerSize',12);
    elseif idx(i,3)==3
        plot(idx(i,1),idx(i,2),'k.','MarkerSize',12);
    elseif idx(i,3)==4
        plot(idx(i,1),idx(i,2),'g.','MarkerSize',12);
    else
         plot(idx(i,1),idx(i,2),'m.','MarkerSize',12);
    end
end
grid on;
% 绘出聚类中心点，kx表示是交叉符,MarkerSize-标记尺寸
plot(ctr(:,1),ctr(:,2),'kx','MarkerSize',12,'LineWidth',2);
%计算NMI指标
a=ones(200,1);
x1=[x1 a];
b=2*ones(200,1);
x2=[x2 b];
c=3*ones(200,1);
x3=[x3 c];
d=4*ones(200,1);
x4=[x4 d];
e=5*ones(200,1);
x5=[x5 e];
data1=[x1;x2;x3;x4;x5];
A=data1(:,3)';
B=idx(:,3)';
MIhat=nmi(A,B);
B=munkres(B);
acc=length(find(A==B))/length(A);
fprintf('best map acc is %f\n', acc)