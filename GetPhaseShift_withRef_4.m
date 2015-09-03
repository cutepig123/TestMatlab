%PathA cell of string
%1. ABout the flag of result, +ve means the pattern shift right, or shift upper in tot90 mode
%2, According to Jiangfan, If wafer moved toward upper, 
% pattern in top camera shifts upper,pattern in btm shifts down
function [Spix]= GetPhaseShift_withRef(PathA, bRot90, logfile, CZY,HWy)

if ~exist('CZY','var')
	CZY= [160   320   480];
end

if ~exist('HWy','var')
	HWy= ones(length(CZY))*50;
end

Spix= 0;


fid= fopen(logfile, 'w');
fclose(fid);

N=length(PathA);
%N=min(10,N);

listing1= PathA{1};

Spix= zeros(N, length(CZY));
imgR= double(imread(listing1));

if (bRot90)
	imgR =imgR';
end

RangeX1=uint32(size(imgR,2)/4);
RangeX2=uint32(size(imgR,2)*3/4);
RangeX =[RangeX1:RangeX2];

for nCases = 1:N
	listingn = PathA{nCases}
	imgI= double(imread(listingn));
	if (bRot90)
		imgI =imgI';
    end

    if nCases==1
        figure
        imshow(uint8(imgI))
         hold on
    end

	y= 1;
	for Czy= CZY;
		hw= HWy(y);
		sinR= sum(imgR(Czy+(-hw:hw), RangeX));
		sinR= (sinR-mean(sinR))/std(sinR);
	
        sinI= sum(imgI(Czy+(-hw:hw), RangeX));
        sinI= (sinI-mean(sinI))/std(sinI);
        
        if nCases==1
            %subplot(length(CZY),1,y)
            %imshow(uint8(imgI(Czy+(-hw:hw), RangeX)))
            %title (sprintf('yidx %d %d->%d',y,Czy-hw,Czy+hw))
            
            plot([RangeX1 RangeX2 RangeX2 RangeX1 RangeX1],[Czy-hw Czy-hw Czy+hw Czy+hw Czy-hw],'r')
            text(double(RangeX1+20),double(Czy-hw+20), sprintf('Region %d',y),'color','red')
        end
        
        k= 1;
        %D= -2:0.01:1.95;
        D= -6:0.01:6;

        sumAbs= length(sinI)- 2;
        for d= D
            s= floor(d);
            r= 1- d+ s;
            sinIs= r*sinI((11+s):(end-10+s))+ (1- r)*sinI(11+s+1:(end-10+s+1));
            sumAbs(k)= sum(abs(sinIs- sinR(11:(end- 10))));
            k= k+ 1;
        end

        [C,I] = min(sumAbs);
        Spix(nCases, y)= D(I);

        y= y+ 1;
    end
    
end

fid= fopen(logfile, 'a+');
for n= 1:N
    listingn = PathA{n};
    fprintf(fid, '%s', listingn);
%             fprintf(fid, '%s', listing(n).name);
    for y= 1:length(CZY)
        fprintf(fid, '\t%f', Spix(n, y));
    end
    fprintf(fid, '\n');
end
fclose(fid);
    