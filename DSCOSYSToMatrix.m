%theta: in degree
function R=DSCOSYSToMatrix(t)
x=t(1);
y=t(2);
theta=t(3);
c =cos(theta*pi/180);
s =sin(theta*pi/180);
R=[c -s x; 
   s c y;
   0 0 1];

