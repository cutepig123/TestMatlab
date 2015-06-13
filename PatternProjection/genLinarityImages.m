for i=0:25
    I=uint8(ones(768,1024)*i*10);
    imwrite( I, sprintf('int\\%d.bmp',i) )
end