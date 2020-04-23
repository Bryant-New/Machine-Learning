function y0=lagrange(x,y,x0)
n=length(x);
I=ones(1,n);
for k=1:n
    for j=1:n
        if j~=k
            I(k)=I(k)*(x0-x(j))/(x(k)-x(j));
        end
    end
end
y0=sum(y.*I);
