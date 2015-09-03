function [Spix]= GetPhaseShift_withRef(PathA, numC)

CZY= [150 250 350];
Spix{numC}= 0;
for c= 1:numC
    listing= dir(sprintf('%s\\*_%d.bmp', PathA, c- 1));
    
    N= length(listing);
    Spix{c}= zeros(N, length(CZY));
    imgR= double(imread(sprintf('%s\\%s', PathA, listing(1).name)));
    
    y= 1;
    for Czy= CZY;
        sinR= sum(imgR(Czy+(-50:50), :));
        sinR= (sinR-mean(sinR))/std(sinR);

        for n= 1:N
            imgI= double(imread(sprintf('%s\\%s', PathA, listing(n).name)));
            sinI= sum(imgI(Czy+(-50:50), :));
            sinI= (sinI-mean(sinI))/std(sinI);

            k= 1;
            D= -2:0.01:1.95;

            sumAbs= length(sinI)- 2;
            for d= D
                s= floor(d);
                r= 1- d+ s;
                sinIs= r*sinI((11+s):(end-10+s))+ (1- r)*sinI(11+s+1:(end-10+s+1));
                sumAbs(k)= sum(abs(sinIs- sinR(11:(end- 10))));
                k= k+ 1;
            end

            [C,I] = min(sumAbs);
            Spix{c}(n, y)= D(I);

            %sinR= sinI;
        end
        y= y+ 1;
    end
    
    fid= fopen(sprintf('%s\\trace_%d.txt', PathA, c- 1), 'w');
    for n= 1:N
        fprintf(fid, '%s', listing(n).name);
        for y= 1:length(CZY)
            fprintf(fid, '\t%f', Spix{c}(n, y));
        end
        fprintf(fid, '\n');
    end
    fclose(fid);
end