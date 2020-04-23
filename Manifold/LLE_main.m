function LLE_main
N=1000;
K=10;
d=2; 
noise = 0.001*randn(1,N);
tt = (3*pi/2)*(1+2*rand(1,N));	
height = 21*rand(1,N); 
X = [(tt+ noise).*cos(tt); height; (tt+ noise).*sin(tt)];
Y=lle(X,K,d);
subplot(1,2,1); 
  scatter3(X(1,:),X(2,:),X(3,:),12,tt,'filed');
   view([12 12]); grid on; axis on; hold on;
    axis on;
    axis equal;
    drawnow;
subplot(1,2,2); 
  scatter(Y(2,:),Y(1,:),12,tt,'filed');  
  grid on;axis on;