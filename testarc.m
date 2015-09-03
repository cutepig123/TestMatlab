close all,clear all,clc
O=rand(2,1);
R=rand()
theta_s=rand()*pi;
theta_e=rand()*pi;
S=O+R*[cos(theta_s);sin(theta_s)];
E=O+R*[cos(theta_e);sin(theta_e)];
theta_m=(theta_s+theta_e)/2;
M=O+R*[cos(theta_m);sin(theta_m)]

thetas=0:0.01:(2*pi);
Allx=O(1)+R*cos(thetas);
Ally=O(2)+R*sin(thetas);
plot(Allx,Ally)

hold on, plot(S(1),S(2),'+'), plot(E(1),E(2),'+'), plot(M(1),M(2),'+')

theta=theta_e-theta_s;
est_A=(S+E)/2;
est_SA=est_A-S;
est_R=abs(norm(est_SA)/sin(theta/2))
est_AO_l=est_R*cos(theta/2);
est_AM_l=est_R-est_AO_l;
est_AM=est_AM_l/norm(est_SA)*[-est_SA(2); est_SA(1)];
est_M=est_A+est_AM
