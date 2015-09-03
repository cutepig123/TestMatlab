function ret=MatrixToDSCOSYS(R)
c =R(2,2);
s =R(2,1);
assert(abs(R(1,1)-R(2,2))<0.001);
assert(abs(R(1,2)+R(2,1))<0.001);
x =R(1,3);
y =R(2,3);
theta =atan2(s,c)*180/pi;
ret=[x,y,theta];
