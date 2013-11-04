%有问题，完全不对

A=imread('a.jpg');
subplot(1,2,1),imshow(A)

B=imread('b.jpg');
subplot(1,2,2),imshow(B)

[x1,y1] = ginput(2);
subplot(1,2,1),hold on, plot(x1,y1, 'r')

[x2,y2] = ginput(2);
subplot(1,2,2),hold on, plot(x2,y2, 'r')

P=[x1(1) y1(1)];
Q=[x1(2) y1(2)];

P_d=[x2(1) y2(1)];
Q_d=[x2(2) y2(2)];

w=1;
P_exp =P*w +P_d*(1-w);
Q_exp =Q*w +Q_d*(1-w);

D=zeros(size(A));
for y=1:size(D,1)
    for x=1:size(D,2)
        X =[x y];
        u =abs(sum((X-P).*(Q-P))/((Q-P)*(Q-P)'));
        perpen =Q-P;
        perpen =[perpen(2) perpen(1)];
        v =(sum((X-P).*perpen)/norm(perpen));
        perpen =Q_exp-P_exp;
        X_2= P_exp +u*(Q_exp- P_exp) + v*perpen/norm(perpen);
        X_2 =uint8(X_2);
        x2 =X_2(1); y2=X_2(2);
        fprintf('%f %f ->%f %f\n',X,X_2)
        if y2>0 & y2<=size(D,1) & x2>0 & x2<=size(D,2)
            D(y2,x2,:) =A(X(2), X(1),:);
        end
    end
end
imshow(D)

