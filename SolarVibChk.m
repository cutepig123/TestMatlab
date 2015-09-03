%% High frequency vibration checking
close all,clc
Path='\\ahkex\ahkproj\Vision_3D\ToShouGor\Bow\WISI3865\pair0\Shear5deg\top';
%Path='\\vis_mc_solar\t\WIG_TestCoverageDB\Solar3D\Function\SawMarkFlipRep\WISI0076\pair0\Shear5deg\top';
F=[Path '\profile.tif_r.tif'];
P=imread(F);
FM=[Path '\profile.tif_ub.bmp'];
M=imread(FM);

% average with mask
Ky=10;  %Kernel size
[Py, My] =SmoothWithMask(P, M, ones(Ky,1));

Kx=100;  %Kernel size
[Px, Mx] =SmoothWithMask(Py, My, ones(1, Kx));

y =100;%size(P,1)/2;
figure,plot(P(y,:),'r');hold on,plot(Px(y,:),'g');title('0.plot original data')
figure,plot(Py(y,:),'r');hold on,plot(Px(y,:),'g');title('1.plot SmoothWithMask_y and SmoothWithMask_x together')

Dif2 = (Py(y,:)-Px(y,:)).*My(y,:).*Mx(y,:);
figure,plot(Dif2),title('2.diff between SmoothWithMask_y and SmoothWithMask_x')

% 50pixel moving window, return max 45/50 data 
Kdomain=50;
order=45;
Dif3 = ordfilt2(abs(Dif2), order, ones(1, Kdomain));
figure,plot(Dif3),title('3.select 10 percent maxmum')
