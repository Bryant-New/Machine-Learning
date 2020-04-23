function LU_dc
A=[5 2 1;-1 4 2;2 -3 10];
b = [-12;20;3];
    D = diag(diag(A));
    L = -tril(A, -1);
    U = -triu(A, 1);
w=0.9;
t = inv(D- w*L);
h=(1-w)*D+w*U;
m=t*h;
n=w*b;
fg=t*n;
x = [0;0;0];
xx =[-2.4;4.4;2.1];
i = 0;
while norm(x - xx, inf) >= 1e-2
	x = xx;
	xx = m * x + fg;
	i = i +1;
end
A=[5 2 1;-1 4 2;2 -3 10];
D = diag(diag(A));
L = -tril(A, -1);
U = -triu(A, 1);
h=inv(D-L)*(U);
B=vrho(h);
