A=imread('a.jpg');
subplot(1,2,1),imshow(A)

B=imread('b.jpg');
subplot(1,2,2),imshow(B)

subplot(1,2,1),hold on,
[x1,y1] = ginput(2);
plot(x1,y1, 'r')
T=[x1'; y1'];
A1=T(:,1)
B1=T(:,2)

subplot(1,2,2),hold on,
[x2,y2] = ginput(2);
plot(x2,y2, 'r')
T=[x2'; y2'];
A2=T(:,1)
B2=T(:,2)

while 1
    [x3,y3] = ginput(1);
    subplot(1,2,1),hold on, plot(x3,y3, '*')
    C1=[x3'; y3']

    A2B2 = B2-A2;
    A1B1 =B1-A1;
    k=norm(A2B2)/norm(A1B1)

    A1C1=C1-A1;
    R=get_r(A1B1, A1C1);
    sita =atan2(-R(2),R(1))*180/pi
    A2C2=k*R*A2B2/norm(A2B2)*norm(A1C1)
    C2=A2+A2C2
    subplot(1,2,2),hold on, plot(C2(1),C2(2), '*')
end