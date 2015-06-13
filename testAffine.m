function main
	Im='F:\images\DCIM\Camera\IMG_20150517_181834.jpg';
	I3 =imread(Im);
	I =I3(:,:,1);
	%PtIn=[2020 4; 3572 108/2; 2104 2228]';
	%PtOut=[2020 4; 3572 4;2020 2228]';
	PtIn=[807 282;1986 12; 807 1287]';
	PtOut=[807 282;1986 282; 807 1287]';
	T =my_get_affine_par(PtIn,PtOut);
	O =my_affine_trans(I, T, size(I));
	imshow(uint8(O))
	
%IN, OUT:	both are 2*3 matrix for 3 2d pts
%T:			2*3 matrix,[OUT(:,i);1]=[T;0 0 1]*[IN(:,i);1] 
%
% [xi 	  [a1 b1 c1]  [xo]
%	yi]=  [a2 b2 c2] *[yo]
% ==>
% [xi]	 [xo yo 1 0 0 0] [a1]
% [yi] = [0 0 0 xo yo 1] [b1]
%						[c1]
%						[a2]
%						[b2]
%						[c2]
function T =my_get_affine_par(IN,OUT)
	A=[];
	B=[];
	for i=1:3
		B=[B;	OUT(:,i)];
		A=[A;	IN(:,i)' 1 0 0 0;	0 0 0 IN(:,i)' 1];
	end
	X =A\B; g
	T =[X(1:3)';	X(4:6)'];

%transform a image	
%szO: size of out image
function O =my_affine_trans(I, T, szO)
szi =size(I);
Tinv3=inv([T;0 0 1]);
Tinv =Tinv3(1:2,:);

O=zeros(szO);
for y=1:size(O,1)
	for x=1:size(O,2)
		XYi=Tinv*[x;y;1];
		xi=int32(XYi(1));
		yi=int32(XYi(2));
		if xi>0 & xi<=szi(2) & yi>0 & yi<=szi(1)
			O(y,x) =I(yi,xi);
		end
	end
end