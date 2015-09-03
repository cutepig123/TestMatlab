function R=buildCosys(x,y,theta)
R=[cos(theta) -sin(theta) x;
    sin(theta) cos(theta) y;
    0 0 1];

function test1
R1=buildCosys(50,50,0);
a1=[100;100;1];
R2=buildCosys(150,150,0);
a2=R2*inv(R1)*a1;

% same as
% SetTranspar(R1, R2, t);
% TransformPr(a1, t,  &a2)
