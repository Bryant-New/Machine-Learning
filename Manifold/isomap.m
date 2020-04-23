function X=isomap(X,k,d) 
% k : neighbors
% x : data set 
% d : low dimension;
if nargin<1
    rand('state',123456789)
end
    N=1000;
    noise = 0.001*randn(1,N);
    tt = (3*pi/2)*(1+2*rand(1,N));	
    height = 21*rand(1,N); 
    X = [(tt+ noise).*cos(tt); height; (tt+ noise).*sin(tt)];
    point_size = 20;
    figure(1)
    cla
    subplot(1,2,1);
    scatter3(X(1,:),X(2,:),X(3,:), point_size,tt,'filled');
    view([12 12]); grid on; axis on; hold on;
    axis on;
    axis equal;
    drawnow;
    X=X';
    k=20;
    d=2;

% step1: Calculate the k nearest distance 
    [m,~]=size(X);
    D=zeros(m);
    for i=1:m
        xx=repmat(X(i,:),m,1);
        diff=xx-X;
        dist=sum(diff.*diff,2);
        [dd,pos]=sort(dist);
        index=pos(1:k+1)';
        index2=pos(k+2:m);
        D(i,index)=sqrt(dd(index));
        D(i,index2)=inf;
    end
    %step2: recalculate shortest distant matrix
for k=1:m
    for i=1:m
        for j=1:m
            if D(i,j)>D(i,k)+D(k,j)
                D(i,j)=D(i,k)+D(k,j);
            end
        end
    end
end
% for i = 1 : m
%     for j = 1 : m
%         if D(i,j) == inf
%             D(i,j) = D(j,i);
%         end
%     end
% end
% step3: adapt MDS algorithm to reduce dimension
Z=MDS(D,d);
subplot(1,2,2);
scatter(Z(1,:),Z(2,:),point_size,tt,'filled');
grid on;axis on;

        
    
    
    
    
    