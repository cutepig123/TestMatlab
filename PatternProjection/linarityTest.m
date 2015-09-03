path='F:\\test_EXPO'
N=1:51
ROIy=800:2200;
ROIx=700:2700;

N=0:25;
path='F:\\test_int'
ROIy=1000:2000;
ROIx=250:2500;

I=[]
for i=N
    P =imread(sprintf('%s\\temp%d.jpg',path,i));
    %i =mean(mean(P(270:2350,60:2650)));
    i =mean(mean(mean(P(ROIy,ROIx,:))))
    I=[I i];
end
I
plot(I)
