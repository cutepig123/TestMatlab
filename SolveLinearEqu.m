function X=SolveLinearEqu(A,B)
sz = size(A);
N = length(B);

T=[A B];
XIdx=1:N;
for i=1:(N-1)
  fprintf('iter %d\n',i);
%找到最大的
  S=T(i:N,i:N);
  [Y,y]=max(abs(S));
  [X,x]=max(Y);
  y=y(x);
  y=y+i-1;
  x=x+i-1;
  %交换y行,i行
  fprintf('\texchange row %d %d\n',y,i);
  t=T(y,:);
  T(y,:)=T(i,:);
  T(i,:)=t;
  %交换x,i列
  fprintf('\texchange col %d %d\n',x,i);
  t=T(:,x);
  T(:,x)=T(:,i);
  T(:,i)=t;
  XIdx([x i])=XIdx([i x]);
  T
  for y=(i+1):N
    %将每一行-*T(y,i)/T(i,i)
    T(y,:) = T(y,:) - T(i,:) * (T(y,i)/T(i,i));
  end
  T
  
end

fprintf('solve\n');
X=zeros(N,1);
for i=N:-1:1
    s=T(i,N+1);
    fprintf('s=%g',s);
    for k=(i+1):N
        s=s-T(i,k)*X(k);
        fprintf('-%g*%g',T(i,k),X(k));
    end
    fprintf('\n');
    X(i)=s/T(i,i);

    fprintf('X[%d]=%g/%g=%g\n',i,s,T(i,i),X(i));
end

fprintf('交换会原来顺序\n');
X2=zeros(N,1);
for i=1:N
    X2(uint32(XIdx(i))) =X(i);
end
X=X2;
