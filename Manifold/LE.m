function X=LE(X,k,d)
% Laplacian Eigenmapping Algorithm (Minifold Learning)
% k : neighbors
% x : data set 
% d : low dimension;
if nargin<1
    N=1000;
    rand('state',123456789);
    noise = 0.001*randn(1,N);
    tt = (3*pi/2)*(1+2*rand(1,N));	
    height = 21*rand(1,N); 
    X = [(tt+ noise).*cos(tt); height; (tt+ noise).*sin(tt)];
    %ÏÔÊ¾Êý¾Ýpoint_size = 20; figure(1)
    point_size = 20; figure(1)
    cla
    subplot(1,2,1);
    scatter3(X(1,:),X(2,:),X(3,:), point_size,tt,'filled'); 
    view([12 12]); grid on; axis on; hold on;
    axis on;
    axis equal;
    drawnow;
    X = X';
    k = 20;
    d = 2;
end
% step1: Calculate the k nearest distance 
[m,~]=size(X);
W=zeros(m);
sigma=10;
for i=1:m
    xx = repmat(X(i, :), m, 1);
    diff = xx - X;
    dist = sum(diff.* diff, 2);
    [dd, pos] = sort(dist);
    index = pos(1 : k + 1)';
    index(index == i) = [];
    W(i,index) = exp(-dd(index) / (2 * sigma ^ 2));
end
W=0.5*(W+W');
D=sum(W,2);
D=diag(D);
M=D-W;
[eigenvector, eigenvalue] = eig(M);
eigenvalue = diag(eigenvalue);
[~,pos] = sort(eigenvalue);
index = pos(1: d+1);
tran = eigenvector(:, index);
p =sum(tran.*tran);
j = find(p == min(p));
tran(:, j) = [];
X=tran;
subplot(1,2,2);
scatter(X(:,1),X(:,2),point_size,tt,'filed');
grid on;axis on;

    
