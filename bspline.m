N=15;
Y=rand(1,N);
X=1:N;

U=0:0.1:1;
A=[-1 3 -3 1;3 -6 3 0;-3 0 3 0;1 4 1 0];
QX=[];
QY=[];
for i = 1:(N-3)
    
    for u = U
        qix=1.0/6*[u^3 u^2 u 1]*A*[X(i) X(i+1) X(i+2) X(i+3)]';
        qiy=1.0/6*[u^3 u^2 u 1]*A*[Y(i) Y(i+1) Y(i+2) Y(i+3)]';
        QX=[QX qix];
        QY=[QY qiy];
    end
end

plot(QX, QY)
hold on
plot(X,Y,'r+-')