close all,clc

S={ 'A:\JSHe\temp\8.Use mono wafer,shim added in CV stand, check with laser\WISO0175\0\0\ubbSBuf.bmp',
'A:\JSHe\temp\8.Use mono wafer,shim added in CV stand, check with laser\WISO0175\0\1\ubbSBuf.bmp',
'A:\JSHe\temp\8.Use mono wafer,shim added in CV stand, check with laser\WISO0175\0\2\ubbSBuf.bmp',
'A:\JSHe\temp\8.Use mono wafer,shim added in CV stand, check with laser\WISO0175\0\3\ubbSBuf.bmp',
'A:\JSHe\temp\8.Use mono wafer,shim added in CV stand, check with laser\WISO0175\0\4\ubbSBuf.bmp',
'A:\JSHe\temp\8.Use mono wafer,shim added in CV stand, check with laser\WISO0175\0\5\ubbSBuf.bmp',
'A:\JSHe\temp\8.Use mono wafer,shim added in CV stand, check with laser\WISO0175\0\6\ubbSBuf.bmp'
};
Res=[];
for i=1:(length(S)-1)
	t =GetPhaseShift_withRef_4({S{i},S{i+1}}, 0, 'c:\temp\1.txt', [200 500],[50 50])
	Res=[Res; t(2,:)];
end	
Res

